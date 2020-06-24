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

final class EmptyTheme: Theme {

    init() {
    }

    func apply(style: LabelStyle, to label: UILabel?) {
    }

    func apply(style: NavigationBarStyle, to navigationBar: UINavigationBar?) {
    }

    func apply(style: ButtonStyle, to button: UIButton?) {
    }

    func apply(style: ViewStyle, to view: UIView?) {
    }

    func apply(style: NavBarStyle, to navigationBar: UINavigationBar?) {
    }

    func apply(style: LayerShadowStyle, to layer: CALayer?) {
    }

    func apply(style: LayerShadowStyle, cornerRadius: CGFloat, to layer: CALayer?) {
    }
}
