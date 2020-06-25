// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

import UIKit

final class DependencyContainer: ViewControllerFactory {
    fileprivate weak var navigator: SceneNavigator?
    fileprivate lazy var theme: Theme = DefaultTheme(fontSet: DefaultFontSet(), colorPalette: DefaultColorPalette())
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

    func makeAlbumDetailsViewController(mbid: String) -> UIViewController {
        let viewController = AlbumDetailsViewController.loadFromStoryboard()
        let viewModel = DefaultAlbumDetailsViewModel(mbid: mbid,
                                                     imageDownloadService: networkService,
                                                     albumInfoService: networkService,
                                                     albumStoreService: databaseService)
        viewController.setupDependencies(viewModel: viewModel, theme: theme)
        return viewController
    }
}
