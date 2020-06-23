import UIKit

final class DefaultFontSet: FontSet {
    var regular: UIFont { .systemFont(ofSize: 15.0) }
    var small: UIFont { .systemFont(ofSize: 12.0) }
}
