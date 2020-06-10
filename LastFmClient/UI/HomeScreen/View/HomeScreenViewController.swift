import UIKit
import RxSwift
import RxCocoa

class HomeScreenViewController: UICollectionViewController, StoryboardLoadable {
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
    private let disposeBag = DisposeBag()
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
        navigator?.navigate(to: .albumDetails(albumId: "63b3a8ca-26f2-4e2b-b867-647a6ec2bebd"))
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

private extension HomeScreenViewController {
    func setupView() {
        registerReusableCells()
        addSearchButton()
        styleView()
        setupBindings()
    }

    func registerReusableCells() {
        collectionView.registerReusableCell(HomeScreenAlbumCell.self)
    }

    func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
    }

    func styleView() {
        theme?.apply(style: .lightDarkBackground, to: collectionView)
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }

    func setupBindings() {
//        viewModel?.onViewModelUpdated = { [weak self] in
//            self?.collectionView.reloadData()
//        }

//        navigationItem.rightBarButtonItem?.rx.bind(to: viweModel.onSearch).disposed(by: disposeBag)
//
//        viewModel?.onSwitchToArtistSearch.bind(onNext: {
//            navigator?.navigate(to: .artistSearch)
//        }).disposed(by: disposeBag)

        viewModel?.albumCells.bind(to:
            collectionView.rx.items(cellIdentifier: AlbumCardViewCell.defaultIdentifier,
                                    cellType: AlbumCardViewCell.self)) { [weak self] _, viewModel, cell in
                cell.set(viewModel: viewModel)
                cell.style(with: self?.theme)
        }.disposed(by: disposeBag)

        //collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}
