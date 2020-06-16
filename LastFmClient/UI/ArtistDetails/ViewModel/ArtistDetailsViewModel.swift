import RxSwift

protocol ArtistDetailsViewModel {
    var artistDetails: Observable<ArtistDetailsCellViewModel> { get }
    var albums: Observable<[AlbumCardViewModel]> { get }

    var showHud: Observable<Bool> { get }
    var showNetworkError: Observable<Void> { get }
    var doActionOnNetworkError: AnyObserver<NetworkErrorAction> { get }

    var doShowFullBio: AnyObserver<Void> { get }
    var showFullBio: Observable<String> { get }

    var doShowAlbumDetails: AnyObserver<Int> { get }
    var showAlbumDetails: Observable<String> { get }

    var doGoBack: AnyObserver<Void> { get }
    var showMainScreen: Observable<Void> { get }
}
