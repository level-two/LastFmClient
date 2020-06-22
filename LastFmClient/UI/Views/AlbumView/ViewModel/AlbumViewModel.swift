import UIKit
import RxSwift
import RxRelay

protocol AlbumViewModel {
    var mbid: String { get }
    var artist: String { get }
    var title: String { get }

    var onCover: Observable<UIImage?> { get }
    var showHud: Observable<Bool> { get }
}
