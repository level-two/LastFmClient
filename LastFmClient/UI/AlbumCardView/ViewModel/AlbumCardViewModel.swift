import UIKit

protocol AlbumCardViewModel {
    var cover: UIImage? { get }
    var title: String { get }
    var inCollection: Bool { get }

    func addToCollection()
    func removeFromCollection()

    var delegate: AlbumCardViewModelDelegate? { get set }
}
