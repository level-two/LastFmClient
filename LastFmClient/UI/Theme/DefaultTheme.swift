import UIKit

class DefaultTheme: Theme {
    fileprivate let fontSet: FontSet
    fileprivate let colorPalette: ColorPalette

    init(fontSet: FontSet, colorPalette: ColorPalette) {
        self.fontSet = fontSet
        self.colorPalette = colorPalette
    }

    func apply(style: LabelStyle, to label: UILabel?) {
        switch style {
        case .normal:
            label?.font = fontSet.regular
            label?.textColor = colorPalette.base
        case .light:
            label?.font = fontSet.regular
            label?.textColor = colorPalette.primary2
        case .dark:
            label?.font = fontSet.regular
            label?.textColor = colorPalette.primary4
        case .description:
            label?.font = fontSet.small
            label?.textColor = colorPalette.base
        }
    }

    func apply(style: NavigationBarStyle, to navigationBar: UINavigationBar?) {
        switch style {
        case .normal:
            navigationBar?.titleTextAttributes = [.foregroundColor: colorPalette.primary1]
            navigationBar?.tintColor = colorPalette.primary1
            navigationBar?.barTintColor = colorPalette.dark1
        }
    }

    func apply(style: ButtonStyle, to button: UIButton?) {
        guard let button = button else { return }

        button.setTitleColor(colorPalette.base, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = button.bounds.height/2

        switch style {
        case .normal:
            button.layer.borderColor = colorPalette.primary1.cgColor
        case .addButton:
            button.layer.borderColor = colorPalette.primary3.cgColor
        case .removeButton:
            button.layer.borderColor = colorPalette.primary4.cgColor
        }
    }

    func apply(style: ViewStyle, to view: UIView?) {
        switch style {
        case .darkBackground:
            view?.backgroundColor = colorPalette.dark1
        case .lightDarkBackground:
            view?.backgroundColor = colorPalette.dark2
        case .semiTransparentBackground:
            view?.backgroundColor = colorPalette.dark2.withAlphaComponent(0.5)
        }
    }

    func apply(style: NavBarStyle, to navigationBar: UINavigationBar?) {
        switch style {
        case .lightDark:
            navigationBar?.isTranslucent = false
            navigationBar?.barTintColor = colorPalette.dark2
            navigationBar?.tintColor = colorPalette.base
            navigationBar?.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: colorPalette.base]
        }
    }

    func apply(style: LayerShadowStyle, to layer: CALayer?) {
        apply(style: style, cornerRadius: 0, to: layer)
    }

    func apply(style: LayerShadowStyle, cornerRadius: CGFloat, to layer: CALayer?) {
        layer?.cornerRadius = cornerRadius

        switch style {
        case .subtleShadow:
            layer?.shadowColor = colorPalette.light1.cgColor
            layer?.shadowOffset = CGSize(width: 0, height: 4)
            layer?.shadowOpacity = 0.1
            layer?.shadowRadius = cornerRadius
        }
    }
}
