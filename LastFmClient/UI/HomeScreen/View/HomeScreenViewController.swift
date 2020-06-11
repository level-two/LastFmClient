import UIKit
import RxSwift
import RxCocoa

class HomeScreenViewController: UIViewController, StoryboardLoadable {
    @IBOutlet private var collectionView: UICollectionView?

    private typealias DataSource = UICollectionViewDiffableDataSource<HomeScreenSections, AlbumCardHashableWrapper>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeScreenSections, AlbumCardHashableWrapper>

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupDependencies(viewModel: HomeScreenViewModel,
                           navigator: SceneNavigator?,
                           theme: Theme) {
        self.viewModel = viewModel
        self.navigator = navigator
        self.theme = theme
    }

    private var viewModel: HomeScreenViewModel?
    private var navigator: SceneNavigator?
    private var theme: Theme?
    private var dataSource: DataSource?
    private let disposeBag = DisposeBag()
}

private extension HomeScreenViewController {
    func setupView() {
        setupCollection()

        addSearchButton()
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
        guard let collectionView = self.collectionView else { return }

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
                //self?.navigator?.navigate(to: .albumDetails(albumId: "63b3a8ca-26f2-4e2b-b867-647a6ec2bebd"))
                self?.viewModel?.onCardSelected(at: indexPath.row)
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

// MARK: - Search and nav bar
private extension HomeScreenViewController {
    func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
    }

    func styleView() {
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }

    func setupBindings() {
//        navigationItem.rightBarButtonItem?.rx.bind(to: viweModel.onSearch).disposed(by: disposeBag)
//
//        viewModel?.onSwitchToArtistSearch.bind(onNext: {
//            navigator?.navigate(to: .artistSearch)
//        }).disposed(by: disposeBag)
    }
}
