import UIKit

extension UICollectionViewCell {
    static var nib: UINib {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: bundle)
    }
}
