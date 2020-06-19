import UIKit
import RxSwift

protocol ArtistDetailsCellViewModel {
    var mbid: String { get }
    var name: String { get }
    var shortDescription: String { get }
    var longDescription: String { get }

    var artistPhoto: Observable<UIImage?> { get }
    var showLoadingHud: Observable<Bool> { get }
}
