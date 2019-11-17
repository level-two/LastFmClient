import UIKit

class ArtistDetailsViewController: UICollectionViewController, StoryboardLoadable {
    fileprivate var navigator: SceneNavigator?
    fileprivate var networkService: NetworkService?
    fileprivate var databaseProvider: DatabaseProvider?
    fileprivate var theme: Theme?

    fileprivate var viewModel: ArtistDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerSupplementaryView(ArtistDetailsHeaderView.self,
                                                 kind: UICollectionView.elementKindSectionHeader)
        collectionView.registerReusableCell(ArtistDetailsAlbumCell.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        styleView()
    }

    func setupDependencies(navigator: SceneNavigator?,
                           networkService: NetworkService,
                           databaseProvider: DatabaseProvider,
                           theme: Theme) {
        self.navigator = navigator
        self.networkService = networkService
        self.databaseProvider = databaseProvider
        self.theme = theme

        self.viewModel = ArtistDetailsViewModel()
    }
}

extension ArtistDetailsViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.albumsViewModel.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ArtistDetailsHeaderView.self,
                                                                   ofKind: UICollectionView.elementKindSectionHeader,
                                                                   for: indexPath)
        if let viewModel = viewModel, let theme = theme {
            view.configure(with: viewModel.headerViewModel)
            view.style(with: theme)
        }
        return view
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ArtistDetailsAlbumCell.self, for: indexPath)
        if let viewModel = viewModel, let theme = theme {
            cell.configure(with: viewModel.albumsViewModel[indexPath.item])
            cell.style(with: theme)
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        navigator?.navigate(to: .albumDetails(albumId: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0"))
    }
}

extension ArtistDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {

        // Get the view for the first header
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind:
                                                UICollectionView.elementKindSectionHeader,
                                             at: indexPath)

        let bounds = collectionView.bounds
        var width = bounds.size.width -
            collectionView.layoutMargins.left - collectionView.layoutMargins.right

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            width -= layout.sectionInset.left + layout.sectionInset.right
        }

        // Use this view to calculate the optimal size based on the collection view's width
        return headerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
            verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt: IndexPath) -> CGSize {

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

extension ArtistDetailsViewController {
    fileprivate func styleView() {
        theme?.apply(style: .lightDarkBackground, to: collectionView)
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }
}
