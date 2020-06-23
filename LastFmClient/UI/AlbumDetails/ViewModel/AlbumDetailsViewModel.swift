import RxSwift

protocol AlbumDetailsViewModel {
    var albumDetails: AlbumViewModel? { get }
    var tracks: [AlbumDetailsTrackCellViewModel]? { get }
    var albumStore: AlbumStoreViewModel? { get }

    var contentIsReady: Observable<Void> { get }

    var showHud: Observable<Bool> { get }
    var showNetworkError: Observable<NetworkErrorOverlayInteractor?> { get }
}
