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

extension UITableView {
    func registerReusableCell<T>(_ type: T.Type) where T: UITableViewCell & TypeIdentifiable {
        self.register(T.self, forCellReuseIdentifier: type.defaultIdentifier)
    }

    func registerReusableCell<T>(_ type: T.Type) where T: UITableViewCell & NibLoadable & TypeIdentifiable {
        self.register(T.nib, forCellReuseIdentifier: type.defaultIdentifier)
    }

    func registerReusableHeaderFooter<T>(_ type: T.Type) where T: NibLoadable & TypeIdentifiable {
        self.register(T.nib, forHeaderFooterViewReuseIdentifier: type.defaultIdentifier)
    }

    func dequeueReusableCell<T>(_ type: T.Type,
                                for indexPath: IndexPath) -> T where T: UITableViewCell & TypeIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: type.defaultIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell of type \(type.defaultIdentifier)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T>(_ type: T.Type) -> T where T: UIView & TypeIdentifiable {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: type.defaultIdentifier) as? T else {
            fatalError("Failed to dequeue reusable header or footer view of type \(type.defaultIdentifier)")
        }
        return view
    }
}
