import UIKit

final class SceneNavigator: Navigator {
    enum Destination {
        case homeScreen
        case artistDetails(mbid: String)
//        case albumDetails(albumId: String)
    }

    fileprivate lazy var factory: ViewControllerFactory = {
        return DependencyContainer(navigator: self)
    }()

    fileprivate weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

fileprivate extension SceneNavigator {
    func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .homeScreen:
            return factory.makeHomeScreenViewController()
        case .artistDetails(let mbid):
            return factory.makeArtistDetailsViewController(mbid: mbid)
//        case .albumDetails(let albumId):
//            return factory.makeAlbumDetailsViewController(albumId: albumId)
        }
    }
}
