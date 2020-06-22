import RxSwift

protocol NetworkErrorOverlayInteractor {
    var retry: AnyObserver<Void> { get }
}
