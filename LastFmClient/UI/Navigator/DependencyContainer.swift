import UIKit

class DependencyContainer: ViewControllerFactory {
    fileprivate weak var navigator: SceneNavigator?

    init(navigator: SceneNavigator) {
        self.navigator = navigator
    }

    func makeHomeScreenViewController() -> UIViewController {
        let viewController = HomeScreenViewController.loadFromStoryboard()
        viewController.setupDependencies(navigator: navigator)
        return viewController
    }

    func makeArtistSearchViewController() -> UIViewController {
        let viewController = ArtistSearchViewController.loadFromStoryboard()
        viewController.setupDependencies(navigator: navigator)
        return viewController
    }

    func makeArtistDetailsViewController() -> UIViewController {
        let viewController = ArtistDetailsViewController.loadFromStoryboard()
        viewController.setupDependencies(navigator: navigator)
        return viewController
    }

    func makeAlbumDetailsViewController() -> UIViewController {
        let viewController = AlbumDetailsViewController.loadFromStoryboard()
        viewController.setupDependencies(navigator: navigator)
        return viewController
    }
}
