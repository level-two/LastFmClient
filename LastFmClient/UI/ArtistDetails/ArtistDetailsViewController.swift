import UIKit

class ArtistDetailsViewController: UIViewController, StoryboardLoadable {
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var collectionViewTopOffsetConstraint: NSLayoutConstraint?
    @IBOutlet weak var artistPhoto: UIImageView?
    @IBOutlet weak var artistPhotoTopOffsetConstraint: NSLayoutConstraint?

    fileprivate var cellsPerRow = 1
    fileprivate var navigator: SceneNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenBounds = UIScreen.main.bounds
        cellsPerRow = min(screenBounds.width, screenBounds.height) > 1000 ? 2 : 1

        collectionView?.registerReusableCell(ArtistInformationCell.self)
        collectionView?.registerReusableCell(ArtistDetailsAlbumCell.self)
    }

    func setupDependencies(navigator: SceneNavigator?) {
        self.navigator = navigator
    }
}

extension ArtistDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : 20
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(ArtistInformationCell.self, for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(ArtistDetailsAlbumCell.self, for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension ArtistDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            else { return .zero }

        let insetsSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right +
            collectionView.contentInset.left + collectionView.contentInset.right

        switch indexPath.section {
        case 0:
            let width = collectionView.bounds.width - insetsSpace
             // TODO: change height basing on cell state via callback
            return CGSize(width: width, height: 150)
        case 1:
            let itemSpacing = flowLayout.minimumInteritemSpacing
            let cellsNum = CGFloat(cellsPerRow)
            let cellSize = (collectionView.bounds.width - insetsSpace - itemSpacing * (cellsNum - 1)) / cellsNum
            return CGSize(width: cellSize, height: cellSize)
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            navigator?.navigate(to: .albumDetails)
        }
    }

}

extension ArtistDetailsViewController: UIScrollViewDelegate {

    // Header parallax effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionViewTopOffsetConstraint = collectionViewTopOffsetConstraint,
            let artistPhotoTopOffsetConstraint = artistPhotoTopOffsetConstraint,
            let artistPhoto = artistPhoto
            else { return }

        let contentOffset = scrollView.contentOffset.y
        var collectionTopOffset = collectionViewTopOffsetConstraint.constant - contentOffset

        if collectionTopOffset > artistPhoto.bounds.height {
            collectionTopOffset = artistPhoto.bounds.height
        } else if collectionTopOffset < 0 {
            collectionTopOffset = 0
        } else {
            scrollView.contentOffset.y = 0 // block scrolling
        }

        collectionViewTopOffsetConstraint.constant = collectionTopOffset
        artistPhotoTopOffsetConstraint.constant = (collectionTopOffset - artistPhoto.bounds.height)/2

        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0 // prevent bouncing
        }
    }
}
