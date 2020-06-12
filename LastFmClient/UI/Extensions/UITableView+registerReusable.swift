import UIKit

extension UITableView {
    func registerReusableCell<T>(_ type: T.Type) where T: UITableViewCell & TypeIdentifiable {
        self.register(T.self, forCellReuseIdentifier: type.defaultIdentifier)
    }

    func registerReusableCell<T>(_ type: T.Type) where T: UITableViewCell & NibLoadable & TypeIdentifiable {
        self.register(T.nib, forCellReuseIdentifier: type.defaultIdentifier)
    }

    func registerReusableHeaderFooter<T>(_ type: T.Type) where T: NibLoadable & TypeIdentifiable {
        self.register(T.nib, forHeaderFooterViewReuseIdentifier: type.defaultIdentifier)
    }

    func dequeueReusableCell<T>(_ type: T.Type,
                                for indexPath: IndexPath) -> T where T: UITableViewCell & TypeIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: type.defaultIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell of type \(type.defaultIdentifier)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T>(_ type: T.Type) -> T where T: UIView & TypeIdentifiable {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: type.defaultIdentifier) as? T else {
            fatalError("Failed to dequeue reusable header or footer view of type \(type.defaultIdentifier)")
        }
        return view
    }
}
