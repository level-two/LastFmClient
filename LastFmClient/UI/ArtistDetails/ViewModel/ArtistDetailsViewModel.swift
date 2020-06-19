import RxSwift

protocol ArtistDetailsViewModel {
    var artistDetails: Observable<[ArtistDetailsCellViewModel]> { get }
    var albums: Observable<[AlbumCardViewModel]> { get }

    var showHud: Observable<Bool> { get }
    var showNetworkError: Observable<Bool> { get }
    var doRetry: AnyObserver<Void> { get }

    var doShowFullBio: AnyObserver<Int> { get }
    var showFullBio: Observable<String> { get }
    var doShowAlbumDetails: AnyObserver<Int> { get }
    var showAlbumDetails: Observable<String> { get }
}
