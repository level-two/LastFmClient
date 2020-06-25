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

final class DefaultTheme: Theme {
    fileprivate let fontSet: FontSet
    fileprivate let colorPalette: ColorPalette

    init(fontSet: FontSet, colorPalette: ColorPalette) {
        self.fontSet = fontSet
        self.colorPalette = colorPalette
    }

    func apply(style: LabelStyle, to label: UILabel?) {
        switch style {
        case .text:
            label?.font = fontSet.regular
            label?.textColor = colorPalette.text
        case .bold:
            label?.font = fontSet.bold
            label?.textColor = colorPalette.text
        case .light:
            label?.font = fontSet.light
            label?.textColor = colorPalette.text
        case .heading:
            label?.font = fontSet.heading
            label?.textColor = colorPalette.text
        }
    }

    func apply(style: ButtonStyle, to button: UIButton?) {
        switch style {
        case .normal:
            button?.setTitleColor(colorPalette.text, for: .normal)
            button?.layer.borderWidth = 1
            button?.layer.borderColor = colorPalette.primary1.cgColor
            button?.layer.cornerRadius = 0.5 * (button?.bounds.height ?? 0)
        }
    }

    func apply(style: ViewStyle, to view: UIView?) {
        switch style {
        case .background:
            view?.backgroundColor = colorPalette.background
        case .surface:
            view?.backgroundColor = colorPalette.surface
        case .semiTransparent:
            view?.backgroundColor = colorPalette.background.withAlphaComponent(0.5)
        }
    }

    func apply(style: NavigationBarStyle, to navigationBar: UINavigationBar?) {
        switch style {
        case .normal:
            navigationBar?.isTranslucent = false
            navigationBar?.barTintColor = colorPalette.background
            navigationBar?.tintColor = colorPalette.primary1
            navigationBar?.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: colorPalette.primary1]
        }
    }

    func apply(style: LayerStyle, to layer: CALayer?) {
        switch style {
        case .roundedWithShadow:
            layer?.shadowColor = colorPalette.shadow.cgColor
            layer?.shadowOffset = CGSize(width: 0, height: 4)
            layer?.shadowOpacity = 1
            layer?.shadowRadius = 16
            layer?.cornerRadius = 16
        }
    }

    func apply(style: ImageStyle, to imageView: UIImageView?) {
        switch style {
        case .tint:
            imageView?.setImageColor(color: colorPalette.primary2)
        }
    }

    func apply(style: ActivityIndicatorStyle, to indicator: UIActivityIndicatorView?) {
        switch style {
        case .normal:
            indicator?.tintColor = colorPalette.primary1
        }
    }

}
