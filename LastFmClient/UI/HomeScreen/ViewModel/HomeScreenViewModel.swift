import RxSwift

protocol HomeScreenViewModel {
    var onStoredAlbums: Observable<[AlbumCardViewModel]> { get }
    var doSelectCard: AnyObserver<Int> { get }

    var onShowAlbumDetails: Observable<String> { get }

    var doSearchModeEnable: AnyObserver<Bool> { get }
    var doArtistSearch: AnyObserver<String> { get }

    var onSearchResults: Observable<[ArtistSearchViewModel]> { get }
    var doSelectSearchItem: AnyObserver<ArtistSearchViewModel> { get }

    var onShowArtistDetails: Observable<String> { get }
}
