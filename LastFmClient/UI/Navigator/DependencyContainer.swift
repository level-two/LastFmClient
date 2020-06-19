import UIKit

final class DependencyContainer: ViewControllerFactory {
    fileprivate weak var navigator: SceneNavigator?
    //fileprivate lazy var theme: Theme = DefaultTheme(fontSet: DefaultFontSet(), colorPalette: DefaultColorPalette())
    fileprivate lazy var theme: Theme = EmptyTheme()
    fileprivate lazy var networkService: NetworkService = AlamofireNetworkService()
    fileprivate lazy var databaseService: DatabaseService = RealmDatabaseService()

    init(navigator: SceneNavigator) {
        self.navigator = navigator
    }

    func makeHomeScreenViewController() -> UIViewController {
        let viewController = HomeScreenViewController.loadFromStoryboard()
        let viewModel = DefaultHomeScreenViewModel(imageDownloadService: networkService,
                                                   artistSearchService: networkService,
                                                   albumStoreService: databaseService,
                                                   searchHistoryService: databaseService)
        viewController.setupDependencies(viewModel: viewModel,
                                         navigator: navigator,
                                         theme: theme)
        return viewController
    }

    func makeArtistDetailsViewController(mbid: String) -> UIViewController {
        let viewController = ArtistDetailsViewController.loadFromStoryboard()
        let viewModel = DefaultArtistDetailsViewModel(imageDownloadService: networkService,
                                                      artistInfoService: networkService,
                                                      albumStoreService: databaseService,
                                                      artistMbid: mbid)
        viewController.setupDependencies(viewModel: viewModel,
                                         navigator: navigator,
                                         theme: theme)
        return viewController
    }

    func makeArtistDescriptionViewController(description: String) -> UIViewController {
        let viewController = ArtistDescriptionViewController.loadFromStoryboard()
        let viewModel = DefaultArtistDescriptionViewModel(with: description)
        viewController.setupDependencies(viewModel: viewModel, theme: theme)
        return viewController
    }

//    func makeAlbumDetailsViewController(albumId: String) -> UIViewController {
//        let viewController = AlbumDetailsViewController.loadFromStoryboard()
//        viewController.setupDependencies(albumId: albumId,
//                                         navigator: navigator,
//                                         networkService: networkService,
//                                         databaseService: databaseService,
//                                         theme: theme)
//        return viewController
//    }
}
