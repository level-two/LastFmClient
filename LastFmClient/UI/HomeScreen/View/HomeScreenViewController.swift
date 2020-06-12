import UIKit
import RxSwift
import RxCocoa

final class HomeScreenViewController: UIViewController, StoryboardLoadable {
    @IBOutlet private var collectionView: UICollectionView?
    @IBOutlet private var searchTableView: UITableView?

    private typealias DataSource = UICollectionViewDiffableDataSource<HomeScreenSections, AlbumCardHashableWrapper>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeScreenSections, AlbumCardHashableWrapper>

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupDependencies(viewModel: HomeScreenViewModel, navigator: SceneNavigator?, theme: Theme) {
        self.viewModel = viewModel
        self.navigator = navigator
        self.theme = theme
    }

    private lazy var searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
    private lazy var searchCloseButton = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
    private lazy var searchBar = UISearchBar()

    private var viewModel: HomeScreenViewModel?
    private var navigator: SceneNavigator?
    private var theme: Theme?
    private var dataSource: DataSource?
    private let disposeBag = DisposeBag()
}

private extension HomeScreenViewController {
    func setupView() {
        setupCollection()
        setupSearchTableView()
        addSearchButtons()
        styleView()
        setupBindings()
    }
}

// MARK: - Collection View
private extension HomeScreenViewController {
    func setupCollection() {
        registerCollectionReusableCells()
        setupCollectionDataSource()
        setupCollectionDelegate()
        setupCollectionBindings()
        setupCollectionStyle()
    }

    func registerCollectionReusableCells() {
        collectionView?.registerReusableCell(AlbumCardViewCell.self)
    }

    func setupCollectionDataSource() {
        guard let collectionView = collectionView else { return }

        let theme = self.theme
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, cardWrapper in
            let cell = collectionView.dequeueReusableCell(AlbumCardViewCell.self, for: indexPath)
            cell.set(viewModel: cardWrapper.wrappedCard)
            cell.style(with: theme)
            return cell
        }
    }

    func setupCollectionDelegate() {
        collectionView?.rx.setDelegate(self).disposed(by: disposeBag)
    }

    func setupCollectionBindings() {
        viewModel?.onStoredAlbums.bind { [weak self] albums in
            var snapshot = Snapshot()
            snapshot.appendSections([.storedAlbums])
            snapshot.appendItems(albums.map(AlbumCardHashableWrapper.init))
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }.disposed(by: disposeBag)

        collectionView?.rx.itemSelected.bind { [weak self] indexPath in
            guard let section = HomeScreenSections(rawValue: indexPath.section) else { return }
            switch section {
            case .storedAlbums:
                self?.viewModel?.doSelectCard.onNext(indexPath.row)
            }
        }.disposed(by: disposeBag)
    }

    func setupCollectionStyle() {
        theme?.apply(style: .lightDarkBackground, to: collectionView)
    }
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt: IndexPath) -> CGSize {
        // FIXME: Issue with resizing after rotation
        guard let flowLayout = layout as? UICollectionViewFlowLayout else {
            return .zero
        }

        let insets = flowLayout.sectionInset.left + flowLayout.sectionInset.right +
            collectionView.contentInset.left + collectionView.contentInset.right

        let contentWidth = collectionView.frame.width
        let availableContentWidth = contentWidth - insets

        let space = flowLayout.minimumInteritemSpacing
        let minCellWidth = 200 + space

        let cellsPerRow = (availableContentWidth / minCellWidth).rounded(.down)
        let cellWidth = (availableContentWidth - space * (cellsPerRow - 1)) / cellsPerRow
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

// MARK: - Table View
private extension HomeScreenViewController {
    func setupSearchTableView() {
        registerSearchTableReusableCells()
        setupSearchTableStyle()
        setupSearchTableBindings()
        setupSearchTableState()
    }

    func registerSearchTableReusableCells() {
        searchTableView?.registerReusableCell(SearchTableCellView.self)
    }

    func setupSearchTableState() {
        searchTableView?.isHidden = true
    }

    func setupSearchTableBindings() {
        guard let tableView = searchTableView, let viewModel = viewModel else { return }

        viewModel.onSearchResults
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableCellView.defaultIdentifier)) { _, element, cell in
                cell.textLabel?.text = element.artist
                cell.accessoryType = .disclosureIndicator
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(ArtistSearchViewModel.self)
            .bind(to: viewModel.doSelectSearchItem)
            .disposed(by: disposeBag)
    }

    func setupSearchTableStyle() {
        theme?.apply(style: .semiTransparentBackground, to: searchTableView)
    }
}

// MARK: - Search and nav bar
private extension HomeScreenViewController {
    func addSearchButtons() {
        navigationItem.rightBarButtonItem = searchButton
    }

    func styleView() {
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }

    func setupBindings() {
        guard let viewModel = viewModel else { return }

//        viewModel?.onShowAlbumDetails
//            .bind { [weak self] mbid self?.navigator?.navigate(to: .albumDetails(mbid)) }
//            .disposed(by: disposeBag)
//
//        viewModel?.onShowArtistDetails
//            .bind { [weak self] mbid self?.navigator?.navigate(to: .artistDetails(mbid)) }
//            .disposed(by: disposeBag)

        searchButton.rx.tap
            .bind { [weak self] in
                self?.searchTableView?.isHidden = false
                self?.navigationItem.rightBarButtonItem = self?.searchCloseButton
                self?.navigationItem.titleView = self?.searchBar
                self?.searchBar.becomeFirstResponder()
                viewModel.doSearchModeEnable.onNext(true)
            }.disposed(by: disposeBag)

        searchCloseButton.rx.tap
            .bind { [weak self] in
                self?.searchTableView?.isHidden = true
                self?.navigationItem.rightBarButtonItem = self?.searchButton
                self?.navigationItem.titleView = nil
                self?.searchBar.resignFirstResponder()
                viewModel.doSearchModeEnable.onNext(false)
            }.disposed(by: disposeBag)
    }
}
