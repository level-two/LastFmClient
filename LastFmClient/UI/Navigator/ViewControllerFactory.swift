import UIKit

protocol ViewControllerFactory: class {
    func makeHomeScreenViewController() -> UIViewController
    func makeArtistSearchViewController() -> UIViewController
    func makeArtistDetailsViewController() -> UIViewController
    func makeAlbumDetailsViewController() -> UIViewController
}
