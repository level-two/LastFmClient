import UIKit

class SceneNavigator: Navigator {
    enum Destination {
        case homeScreen
        case artistSearch
        case artistDetails
        case albumDetails
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
        case .artistSearch:
            return factory.makeArtistSearchViewController()
        case .artistDetails:
            return factory.makeArtistDetailsViewController()
        case .albumDetails:
            return factory.makeAlbumDetailsViewController()
        }
    }
}
