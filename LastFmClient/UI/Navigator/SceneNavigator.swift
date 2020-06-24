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

final class SceneNavigator: Navigator {
    enum Destination {
        case homeScreen
        case artistDetails(mbid: String)
        case artistDescription(description: String)
        case albumDetails(mbid: String)
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
        case .artistDescription(let description):
            return factory.makeArtistDescriptionViewController(description: description)
        case .albumDetails(let mbid):
            return factory.makeAlbumDetailsViewController(mbid: mbid)
        }
    }
}
