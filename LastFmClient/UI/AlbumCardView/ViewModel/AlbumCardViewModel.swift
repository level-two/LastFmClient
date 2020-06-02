import UIKit
import RxSwift

protocol AlbumCardViewModel {
    var artist: String { get }
    var title: String { get }

    var cover: Observable<UIImage> { get }
    var onShowLoadingHud: Observable<Bool> { get }

    var stored: Observable<Bool> { get }


}
