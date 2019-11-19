import UIKit

class HomeScreenViewController: UICollectionViewController, StoryboardLoadable {
    fileprivate var navigator: SceneNavigator?
    fileprivate var theme: Theme?
    fileprivate var viewModel: HomeScreenViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerReusableCell(HomeScreenAlbumCell.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self,
                                                            action: #selector(self.onSearchButton(sender:)))
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
        self.theme = theme
        // TODO: Think of constructing veiw model outside view controller
        self.viewModel = HomeScreenViewModel(networkService: networkService,
                                             databaseProvider: databaseProvider)

        viewModel?.onViewModelUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    @objc func onSearchButton(sender: UIBarButtonItem) {
        navigator?.navigate(to: .artistSearch)
    }
}

extension HomeScreenViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.albumsViewModel.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(HomeScreenAlbumCell.self, for: indexPath)
        if let viewModel = viewModel, let theme = theme {
            cell.configure(with: viewModel.albumsViewModel[indexPath.item])
            cell.style(with: theme)
        }

        cell.onRemove = { [weak self] in
            self?.viewModel?.removeAlbum(at: indexPath.item)
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigator?.navigate(to: .albumDetails(albumId: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0"))
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

extension HomeScreenViewController {
    fileprivate func styleView() {
        theme?.apply(style: .lightDarkBackground, to: collectionView)
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }
}
