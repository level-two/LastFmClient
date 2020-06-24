// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

final class HomeScreenViewController: UIViewController, StoryboardLoadable {
    @IBOutlet private var collectionView: UICollectionView?
    @IBOutlet private var searchTableView: UITableView?

    private typealias DataSource = UICollectionViewDiffableDataSource<HomeScreenSection, AlbumCardHashableWrapper>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeScreenSection, AlbumCardHashableWrapper>

    private enum UiMode {
        case normal
        case search
    }

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
    private let uiMode = BehaviorRelay<UiMode>(value: .normal)
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
        setupCollectionLayout()
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

    func setupCollectionLayout() {
        collectionView?.collectionViewLayout = createLayout()
    }

    func setupCollectionBindings() {
        guard let viewModel = viewModel else { return }

        viewModel.onStoredAlbums.bind { [weak self] albums in
            var snapshot = Snapshot()
            snapshot.appendSections([.storedAlbums])
            snapshot.appendItems(albums.map(AlbumCardHashableWrapper.init))
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }.disposed(by: disposeBag)

        collectionView?.rx.itemSelected
            .compactMap { [weak self] indexPath in self?.dataSource?.itemIdentifier(for: indexPath) }
            .map { $0.wrappedCard }
            .bind(to: viewModel.doSelectCard)
            .disposed(by: disposeBag)
    }

    func setupCollectionStyle() {
        theme?.apply(style: .lightDarkBackground, to: collectionView)
    }
}

private extension HomeScreenViewController {

    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, environment in
            let containerSize = environment.container.effectiveContentSize

            let columns = containerSize.width > 1000 ? 4 :
                          containerSize.width > 600 ? 2 : 1

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(20)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 20
            section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)

            return section
        }
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
        guard let tableView = searchTableView else { return }

        viewModel?.onSearchResults
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableCellView.defaultIdentifier)) { _, element, cell in
                cell.textLabel?.text = element.artist
                cell.accessoryType = .disclosureIndicator
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(ArtistSearchItem.self)
            .bind { [weak self] item in
                self?.viewModel?.doSelectSearchItem.onNext(item)
            }.disposed(by: disposeBag)

        RxKeyboard.instance
            .visibleHeight
            .asObservable().bind { [weak self] visibleHeight in
                guard let self = self else { return }
                let inset = visibleHeight == 0 ? 0 : visibleHeight - self.view.safeAreaInsets.bottom
                self.searchTableView?.contentInset.bottom = inset
                self.searchTableView?.verticalScrollIndicatorInsets.bottom = inset
            }.disposed(by: disposeBag)
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
        theme?.apply(style: .lightDarkBackground, to: self.view)
    }

    func setupBindings() {
        guard let viewModel = viewModel else { return }

        viewModel.onShowAlbumDetails
            .bind { [weak self] mbid in self?.navigator?.navigate(to: .albumDetails(mbid: mbid)) }
            .disposed(by: disposeBag)

        viewModel.onShowArtistDetails
            .bind { [weak self] mbid in self?.navigator?.navigate(to: .artistDetails(mbid: mbid)) }
            .disposed(by: disposeBag)

        searchBar.rx
            .text.orEmpty
            .bind(to: viewModel.doArtistSearch)
            .disposed(by: disposeBag)

        Observable
            .merge(searchButton.rx.tap.map { .search },
                   searchCloseButton.rx.tap.map { .normal },
                   viewModel.onShowAlbumDetails.map { _ in .normal },
                   viewModel.onShowArtistDetails.map { _ in .normal })
            .bind(to: uiMode)
            .disposed(by: disposeBag)

        uiMode.bind { [weak self] mode in
            switch mode {
            case .normal:
                self?.searchTableView?.isHidden = true
                self?.navigationItem.rightBarButtonItem = self?.searchButton
                self?.navigationItem.titleView = nil
                self?.searchBar.resignFirstResponder()
                self?.searchBar.text = ""
                self?.viewModel?.doArtistSearch.onNext("")
            case .search:
                self?.searchTableView?.isHidden = false
                self?.navigationItem.rightBarButtonItem = self?.searchCloseButton
                self?.navigationItem.titleView = self?.searchBar
                self?.searchBar.becomeFirstResponder()
            }
        }.disposed(by: disposeBag)
    }
}
