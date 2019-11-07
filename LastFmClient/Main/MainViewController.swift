import UIKit

class MainViewController: UICollectionViewController {
    fileprivate let reuseIdentifier = "AlbumCardCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(AlbumCardCell.nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {

        return 10
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? AlbumCardCell else {
            return UICollectionViewCell()
        }

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
