import UIKit

class DefaultTheme: Theme {
    fileprivate let fontSet: FontSet
    fileprivate let colorPalette: ColorPalette

    required init(fontSet: FontSet, colorPalette: ColorPalette) {
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

    func apply(style: ViewStyle, to view: UIView?) {
        switch style {
        case .cardBackground:
            view?.backgroundColor = colorPalette.primary4
        case .collectionBackground:
            view?.backgroundColor = colorPalette.primary3
        case .tableBackground:
            view?.backgroundColor = colorPalette.dark1
        case .tableHeaderBackground:
            view?.backgroundColor = colorPalette.dark1
        case .tableFooterBackground:
            view?.backgroundColor = colorPalette.dark1
        case .tableCellBackground:
            view?.backgroundColor = colorPalette.dark1
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
}
