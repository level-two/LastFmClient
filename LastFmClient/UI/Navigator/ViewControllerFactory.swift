import UIKit

protocol ViewControllerFactory: class {
    func makeHomeScreenViewController() -> UIViewController
    func makeArtistDetailsViewController(mbid: String) -> UIViewController
    func makeArtistDescriptionViewController(description: String) -> UIViewController
//    func makeAlbumDetailsViewController(albumId: String) -> UIViewController
}
