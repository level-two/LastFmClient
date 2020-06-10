import UIKit

extension UICollectionView {
    func registerReusableCell<T>(_ type: T.Type) where T: UICollectionViewCell & NibLoadable {
        register(T.nib, forCellWithReuseIdentifier: String(describing: type))
    }

    func registerSupplementaryView<T>(_ type: T.Type, kind: String) where T: UICollectionReusableView & NibLoadable {
        register(T.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: type))
    }

    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell of type \(String(describing: type))")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T>(_ type: T.Type,
                                             ofKind kind: String,
                                             for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: String(describing: type),
                                                          for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable supplementary view of \(String(describing: type)), kind \(kind)")
        }
        return view
    }
}
