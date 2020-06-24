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

extension UICollectionView {
    func registerReusableCell<T>(_ type: T.Type) where T: UICollectionViewCell & NibLoadable {
        register(T.nib, forCellWithReuseIdentifier: String(describing: type))
    }

    func registerSupplementaryView<T>(_ type: T.Type, kind: String) where T: UICollectionReusableView & NibLoadable {
        register(T.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: type))
    }

    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell of type \(String(describing: type))")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T>(_ type: T.Type,
                                             ofKind kind: String,
                                             for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: String(describing: type),
                                                          for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable supplementary view of \(String(describing: type)), kind \(kind)")
        }
        return view
    }
}
