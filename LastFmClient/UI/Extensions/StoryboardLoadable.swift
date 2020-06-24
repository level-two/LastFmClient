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

protocol StoryboardLoadable where Self: UIViewController {
    static func loadFromStoryboard() -> Self
}

extension StoryboardLoadable {
    static func loadFromStoryboard() -> Self {
        let bundle = Bundle(for: self)
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        guard let concreteViewController = viewController as? Self else {
            fatalError("Failed cast loaded view controller to type \(String(describing: self))")
        }
        return concreteViewController
    }
}
