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

enum LabelStyle {
    case text
    case bold
    case light
    case heading
}

enum NavigationBarStyle {
    case normal
}

enum TableCellStyle {
    case normal
}

enum TableHeaderFooterStyle {
    case normal
}

enum CollectionCellStyle {
    case normal
}

enum CollectionReusableViewStyle {
    case normal
}

enum ButtonStyle {
    case normal
}

enum ImageStyle {
    case tint
}

enum ViewStyle {
    case background
    case surface
    case semiTransparent
}

enum LayerStyle {
    case roundedWithShadow
}

enum ActivityIndicatorStyle {
    case normal
}

protocol Theme {
    func apply(style: LabelStyle, to label: UILabel?)
    func apply(style: ButtonStyle, to button: UIButton?)
    func apply(style: ViewStyle, to view: UIView?)
    func apply(style: ImageStyle, to view: UIImageView?)
    func apply(style: NavigationBarStyle, to imageView: UINavigationBar?)
    func apply(style: LayerStyle, to layer: CALayer?)
    func apply(style: ActivityIndicatorStyle, to indicator: UIActivityIndicatorView?)
}
