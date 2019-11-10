import UIKit

enum LabelStyle {
    case normal
    case dark
    case description
}

enum NavigationBarStyle {
    case normal
}

enum ViewStyle {
    case cardBackground
    case collectionBackground
    case tableBackground
    case tableHeaderBackground
    case tableCellBackground
}

protocol Theme {
    init(fontSet: FontSet, colorPalette: ColorPalette)
    func apply(style: LabelStyle, to label: UILabel?)
    func apply(style: NavigationBarStyle, to navigationBar: UINavigationBar?)
    func apply(style: ViewStyle, to interfaceElement: UIView?)
}
