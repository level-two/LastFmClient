import UIKit

protocol ArtistDetailsCellViewModel {
    var mbid: String { get }
    var photo: UIImage? { get }
    var name: String { get }
    var shortDescription: String { get }
    var longDescription: String { get }
}
