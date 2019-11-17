import UIKit

class HomeScreenViewController: UICollectionViewController, StoryboardLoadable {
    fileprivate var navigator: SceneNavigator?
    fileprivate var theme: Theme?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerReusableCell(AlbumCardCell.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self,
                                                            action: #selector(self.onSearchButton(sender:)))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        styleView()
    }

    func setupDependencies(navigator: SceneNavigator?, theme: Theme) {
        self.navigator = navigator
        self.theme = theme
    }

    @objc func onSearchButton(sender: UIBarButtonItem) {
        navigator?.navigate(to: .artistSearch)
    }
}

extension HomeScreenViewController {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(AlbumCardCell.self, for: indexPath)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigator?.navigate(to: .albumDetails(albumId: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0"))
    }
}

extension HomeScreenViewController {
    fileprivate func styleView() {
        theme?.apply(style: .lightDarkBackground, to: collectionView)
        theme?.apply(style: .lightDark, to: navigationController?.navigationBar)
    }
}
