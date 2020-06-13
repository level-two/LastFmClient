import RxSwift

protocol HomeScreenViewModel {
    var onStoredAlbums: Observable<[AlbumCardViewModel]> { get }
    var doSelectCard: AnyObserver<Int> { get }

    var onShowAlbumDetails: Observable<String> { get }

    var doSearchModeEnable: AnyObserver<Bool> { get }
    var doArtistSearch: AnyObserver<String> { get }

    var onSearchResults: Observable<[ArtistSearchItem]> { get }
    var doSelectSearchItem: AnyObserver<ArtistSearchItem> { get }

    var onShowArtistDetails: Observable<String> { get }
}
