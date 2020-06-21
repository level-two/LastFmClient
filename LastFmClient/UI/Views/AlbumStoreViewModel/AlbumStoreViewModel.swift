import UIKit
import RxSwift

protocol AlbumStoreViewModel {
    var stored: Observable<Bool> { get }
    var store: AnyObserver<Void> { get }
}
