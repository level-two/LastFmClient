import UIKit

final class DefaultFontSet: FontSet {
    var regular: UIFont { return .systemFont(ofSize: 15.0) }
    var small: UIFont { return .systemFont(ofSize: 12.0) }
}
