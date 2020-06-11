import UIKit
import RxSwift
import RxRelay

protocol AlbumCardViewModel {
    var mbid: String { get }
    var artist: String { get }
    var title: String { get }

    var onCover: Observable<UIImage?> { get }
    var onShowLoadingHud: Observable<Bool> { get }
    var onStored: Observable<Bool> { get }

    var onStoreButton: AnyObserver<()> { get }

    func downloadContent()
}
