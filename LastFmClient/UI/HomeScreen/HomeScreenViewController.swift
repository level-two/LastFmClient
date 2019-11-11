import UIKit

class HomeScreenViewController: UICollectionViewController, StoryboardLoadable {
    fileprivate var navigator: SceneNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerReusableCell(AlbumCardCell.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self,
                                                            action: #selector(self.onSearchButton(sender:)))
    }

    func setupDependencies(navigator: SceneNavigator?) {
        self.navigator = navigator
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
        // FIXME
        navigator?.navigate(to: .albumDetails(albumId: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0"))
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
//extension MainViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath == largePhotoIndexPath {
//            let flickrPhoto = photo(for: indexPath)
//            var size = collectionView.bounds.size
//            size.height -= (sectionInsets.top + sectionInsets.right)
//            size.width -= (sectionInsets.left + sectionInsets.right)
//            return flickrPhoto.sizeToFillWidth(of: size)
//        }
//
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
//}
