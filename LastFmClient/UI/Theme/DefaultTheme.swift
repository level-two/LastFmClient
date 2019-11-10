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
        case .dark:
            label?.font = fontSet.regular
            label?.textColor = colorPalette.primary4
        case .description:
            label?.font = fontSet.small
            label?.textColor = colorPalette.primary4
        }
    }

    func apply(style: NavigationBarStyle, to navigationBar: UINavigationBar?) {
        switch style {
        case .normal:
            navigationBar?.tintColor = colorPalette.primary1
            navigationBar?.barTintColor = colorPalette.primary5
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
        case .tableCellBackground:
            view?.backgroundColor = colorPalette.dark1

        }
    }
}
