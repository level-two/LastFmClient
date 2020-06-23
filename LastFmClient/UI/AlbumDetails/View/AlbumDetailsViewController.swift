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
        setupCollectionView()
    }

    func styleView() {
        theme?.apply(style: .lightDarkBackground, to: collectionView)
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }
}

private extension AlbumDetailsViewController {
    func setupCollectionView() {
        registerReusableCells()
        setupLayout()
        setupDataSource()
        setupContent()
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
        guard let collectionView = collectionView,
            let viewModel = viewModel,
            let theme = theme
            else { return }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, _ in
            guard let section = AlbumDetailsViewSection(rawValue: indexPath.section) else {
                fatalError("Undefined section")
            }

            switch section {
            case .albumDetails:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsAlbumCellView.self, for: indexPath)
                cell.configure(with: viewModel.albumDetails)
                cell.style(with: theme)
                return cell
            case .tracks:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsTrackCellView.self, for: indexPath)
                cell.configure(with: viewModel.tracks[indexPath.item])
                cell.style(with: theme)
                return cell
            case .albumStore:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsStoreCellView.self, for: indexPath)
                cell.configure(with: viewModel.albumStore)
                cell.style(with: theme)
                return cell
            }
        }
    }

    func setupContent() {
        guard let viewModel = viewModel else { return }

        var snapshot = Snapshot()
        snapshot.appendSections([.albumDetails, .tracks, .albumStore])
        snapshot.appendItems([UUID()], toSection: .albumDetails)
        snapshot.appendItems(viewModel.tracks.map { _ in UUID() }, toSection: .tracks)
        snapshot.appendItems([UUID()], toSection: .albumStore)
        dataSource?.apply(snapshot, animatingDifferences: true)
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
                                                      heightDimension: .estimated(500))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(500))

                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let artistSection = NSCollectionLayoutSection(group: group)
                //artistSection.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)

                return artistSection

            case .tracks:
                let containerSize = environment.container.effectiveContentSize

                let columns = containerSize.width > 1000 ? 4 :
                              containerSize.width > 600 ? 2 : 1

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(1.0/CGFloat(columns)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
                group.interItemSpacing = .fixed(20)

                let albumsSection = NSCollectionLayoutSection(group: group)
                albumsSection.interGroupSpacing = 20
                albumsSection.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)

                return albumsSection

            case .albumStore:
                let containerSize = environment.container.effectiveContentSize

                let columns = containerSize.width > 1000 ? 4 :
                              containerSize.width > 600 ? 2 : 1

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(1.0/CGFloat(columns)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
                group.interItemSpacing = .fixed(20)

                let albumsSection = NSCollectionLayoutSection(group: group)
                albumsSection.interGroupSpacing = 20
                albumsSection.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)

                return albumsSection
            }
        }
    }
}
