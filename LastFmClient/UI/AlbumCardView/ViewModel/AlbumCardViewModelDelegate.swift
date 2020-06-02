import UIKit

protocol AlbumCardViewModelDelegate {
    func coverImageLoadStarted()
    func coverImageLoadFinished(image: UIImage)
}
