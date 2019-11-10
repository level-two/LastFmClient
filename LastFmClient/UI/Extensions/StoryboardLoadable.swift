import UIKit

protocol StoryboardLoadable where Self: UIViewController {
    static func loadFromStoryboard() -> Self
}

extension StoryboardLoadable {
    static func loadFromStoryboard() -> Self {
        let bundle = Bundle(for: self)
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        guard let concreteViewController = viewController as? Self else {
            fatalError("Failed cast loaded view controller to type \(String(describing: self))")
        }
        return concreteViewController
    }
}
