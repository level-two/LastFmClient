import UIKit

extension UITableView {
    func registerReusableCell<T>(_ type: T.Type) where T: UITableViewCell & NibLoadable {
        self.register(T.nib, forCellReuseIdentifier: String(describing: type))
    }

    func registerReusableHeaderFooter<T>(_ type: T.Type) where T: NibLoadable {
        self.register(T.nib, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }

    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell of type \(String(describing: type))")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T>(_ type: T.Type) -> T where T: UIView {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T else {
            fatalError("Failed to dequeue reusable header or footer view of type \(String(describing: type))")
        }
        return view
    }
}
