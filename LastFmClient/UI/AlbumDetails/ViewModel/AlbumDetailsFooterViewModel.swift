import RxSwift

protocol AlbumDetailsFooterViewModel {
    var stored: Observable<Bool> { get }
    var storeAlbum: AnyObserver<Void> { get }
}
