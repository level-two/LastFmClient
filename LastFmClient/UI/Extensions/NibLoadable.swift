import UIKit

protocol NibLoadable where Self: UIView {
    static var nib: UINib { get }
    func loadFromNib()
}

extension NibLoadable {
    static var nib: UINib {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: bundle)
    }

    func loadFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))

        guard let views = bundle.loadNibNamed(nibName, owner: self, options: nil) else {
            fatalError("Failed to load nib \(nibName) from bundle \(String(describing: bundle))")
        }

        guard let view = views.first as? UIView else {
            fatalError("Failed to get view from nib \(nibName) in the bundle \(String(describing: bundle))")
        }

        view.frame = self.bounds
        self.addSubview(view)
    }
}
