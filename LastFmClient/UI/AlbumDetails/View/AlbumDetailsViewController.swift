import UIKit
import RxSwift
import RxRelay

final class AlbumDetailsViewController: UIViewController, StoryboardLoadable {
    @IBOutlet private var collectionView: UICollectionView?

    private typealias DataSource = UICollectionViewDiffableDataSource<AlbumDetailsViewSection, UUID>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<AlbumDetailsViewSection, UUID>

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupDependencies(viewModel: AlbumDetailsViewModel, theme: Theme) {
        self.viewModel = viewModel
        self.theme = theme
    }

    private let disposeBag = DisposeBag()
    private var dataSource: DataSource?
    private var theme: Theme?
    private var viewModel: AlbumDetailsViewModel?
}

private extension AlbumDetailsViewController {
    func setupView() {
        styleView()
        setupBindings()
        setupCollectionView()
    }

    func styleView() {
        theme?.apply(style: .lightDarkBackground, to: collectionView)
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }

    func setupBindings() {
        viewModel?.showNetworkError
            .bind(to: self.view.rx.showNetworkErrorOverlay)
            .disposed(by: disposeBag)

        viewModel?.showHud
            .bind(to: self.view.rx.showHud)
            .disposed(by: disposeBag)
    }
}

private extension AlbumDetailsViewController {
    func setupCollectionView() {
        registerReusableCells()
        setupLayout()
        setupDataSource()
        bindDataSource()
    }

    func registerReusableCells() {
        collectionView?.registerReusableCell(AlbumDetailsAlbumCellView.self)
        collectionView?.registerReusableCell(AlbumDetailsTrackCellView.self)
        collectionView?.registerReusableCell(AlbumDetailsStoreCellView.self)
    }

    func setupLayout() {
        collectionView?.collectionViewLayout = createLayout()
    }

    func setupDataSource() {
        guard let collectionView = collectionView else { return }

        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, _ in
            guard let section = AlbumDetailsViewSection(rawValue: indexPath.section) else {
                fatalError("Undefined section")
            }

            guard let albumDetails = self?.viewModel?.albumDetails,
                let tracks = self?.viewModel?.tracks,
                let albumStore = self?.viewModel?.albumStore
                else { return nil }

            switch section {
            case .albumDetails:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsAlbumCellView.self, for: indexPath)
                cell.configure(with: albumDetails)
                cell.style(with: self?.theme)
                return cell
            case .tracks:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsTrackCellView.self, for: indexPath)
                cell.configure(with: tracks[indexPath.item])
                cell.style(with: self?.theme)
                return cell
            case .albumStore:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsStoreCellView.self, for: indexPath)
                cell.configure(with: albumStore)
                cell.style(with: self?.theme)
                return cell
            }
        }
    }

    func bindDataSource() {
        viewModel?.contentIsReady.bind { [weak self] in
            var snapshot = Snapshot()

            snapshot.appendSections([.albumDetails])
            snapshot.appendItems([UUID()], toSection: .albumDetails)

            if let tracks = self?.viewModel?.tracks {
                snapshot.appendSections([.tracks])
                snapshot.appendItems(tracks.map { _ in UUID() }, toSection: .tracks)
            }

            snapshot.appendSections([.albumStore])
            snapshot.appendItems([UUID()], toSection: .albumStore)
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }.disposed(by: disposeBag)
    }
}

private extension AlbumDetailsViewController {
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, environment in
            guard let section = AlbumDetailsViewSection(rawValue: section) else {
                fatalError("Undefined section")
            }

            switch section {
            case .albumDetails:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(1))

                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let artistSection = NSCollectionLayoutSection(group: group)
                artistSection.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
                return artistSection

            case .tracks:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(1))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let albumsSection = NSCollectionLayoutSection(group: group)
                albumsSection.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
                return albumsSection

            case .albumStore:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(1))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(20)

                let albumStore = NSCollectionLayoutSection(group: group)
                albumStore.interGroupSpacing = 20
                albumStore.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
                return albumStore
            }
        }
    }
}
