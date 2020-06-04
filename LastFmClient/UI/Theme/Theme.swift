import UIKit

enum LabelStyle {
    case normal
    case light
    case dark
    case description
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
    case addButton
    case removeButton
}

enum ViewStyle {
    case darkBackground
    case lightDarkBackground
}

enum NavBarStyle {
    case lightDark
}

enum LayerShadowStyle {
    case subtleShadow
}

protocol Theme {
    func apply(style: LabelStyle, to label: UILabel?)
    func apply(style: ButtonStyle, to button: UIButton?)
    func apply(style: ViewStyle, to view: UIView?)
    func apply(style: NavBarStyle, to view: UINavigationBar?)
    func apply(style: LayerShadowStyle, cornerRadius: CGFloat, to layer: CALayer?)
}
