import UIKit

protocol AlbumCardViewModel {
    var cover: UIImage? { get }
    var title: String { get }
    var year: String { get }
    var tracksNumber: Int { get }
    var inCollection: Bool { get }
}
