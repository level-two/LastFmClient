import RxSwift

final class DefaultNetworkErrorOverlayInteractor: NetworkErrorOverlayInteractor {
    let retry: AnyObserver<Void>

    init(retry: AnyObserver<Void>) {
        self.retry = retry
    }
}
