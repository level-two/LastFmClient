import UIKit

class MainViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.registerReusableCell(AlbumCardCell.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(self.action(sender:)))
    }

    @objc func action(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ArtistSearch", sender: nil)
    }
}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(AlbumCardCell.self, for: indexPath)
        return cell
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
