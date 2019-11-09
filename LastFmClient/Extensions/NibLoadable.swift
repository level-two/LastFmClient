import UIKit

protocol NibLoadable where Self: UIView {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: bundle)
    }
}
