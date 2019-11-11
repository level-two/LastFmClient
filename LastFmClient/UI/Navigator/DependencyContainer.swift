import UIKit

class DependencyContainer: ViewControllerFactory {
    fileprivate weak var navigator: SceneNavigator?
    fileprivate lazy var theme: Theme = DefaultTheme(fontSet: DefaultFontSet(), colorPalette: DefaultColorPalette())
    fileprivate lazy var networkService = NetworkService()
    fileprivate lazy var defaultDatabaseProvider = DefaultDatabaseProvider()

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

    func makeAlbumDetailsViewController(albumId: String) -> UIViewController {
        let viewController = AlbumDetailsViewController.loadFromStoryboard()
        viewController.setupDependencies(albumId: albumId,
                                         navigator: navigator,
                                         networkService: networkService,
                                         databaseProvider: defaultDatabaseProvider,
                                         theme: theme)
        return viewController
    }
}
