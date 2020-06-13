import RxSwift
import RxRelay
import PromiseKit

final class DefaultHomeScreenViewModel: HomeScreenViewModel {
    var onStoredAlbums: Observable<[AlbumCardViewModel]> { storedAlbums.asObservable() }
    var onShowAlbumDetails: Observable<String> { doShowAlbumDetails.asObservable() }
    var doSelectCard: AnyObserver<Int> { onCardSelected.asObserver() }

    var doSearchModeEnable: AnyObserver<Bool> { onSearchModeEnable.asObserver() }
    var doArtistSearch: AnyObserver<String> { onArtistSearch.asObserver() }

    var onSearchResults: Observable<[ArtistSearchMatch]> { searchResults.asObservable() }
    var doSelectSearchItem: AnyObserver<ArtistSearchMatch> { onSearchItemSelected.asObserver() }
    var onShowArtistDetails: Observable<String> { doShowArtistDetails.asObservable() }

    init(imageDownloadService: ImageDownloadService,
         artistSearchService: ArtistSearchService,
         albumStoreService: AlbumStoreService,
         searchHistoryService: ArtistSearchHistoryService) {

        self.imageDownloadService = imageDownloadService
        self.artistSearchService = artistSearchService
        self.albumStoreService = albumStoreService
        self.searchHistoryService = searchHistoryService

        setupBindings()
    }

    private let storedAlbums = BehaviorRelay<[AlbumCardViewModel]>(value: [])
    private let doShowAlbumDetails = BehaviorRelay<String>(value: "")
    private let onCardSelected = PublishSubject<Int>()

    private let onSearchModeEnable = PublishSubject<Bool>()
    private let onArtistSearch = PublishSubject<String>()

    private let searchResults = BehaviorRelay<[ArtistSearchMatch]>(value: [])
    private let onSearchItemSelected = PublishSubject<ArtistSearchMatch>()
    private let doShowArtistDetails = BehaviorRelay<String>(value: "")

    private let artistSearchService: ArtistSearchService
    private let imageDownloadService: ImageDownloadService
    private let albumStoreService: AlbumStoreService
    private let searchHistoryService: ArtistSearchHistoryService

    private let disposeBag = DisposeBag()
}

private extension DefaultHomeScreenViewModel {
    func setupBindings() {
        let imageDownloadService = self.imageDownloadService
        let albumStoreService = self.albumStoreService

        albumStoreService.storedAlbums()
            .map { albums in
                albums.map { DefaultAlbumCardViewModel(album: $0,
                                                       imageDownloadService: imageDownloadService,
                                                       albumStoreService: albumStoreService) }
            }.bind(to: storedAlbums)
            .disposed(by: disposeBag)

        onCardSelected
            .compactMap { [weak self] index in self?.storedAlbums.value[safe: index]?.mbid }
            .bind(to: doShowAlbumDetails)
            .disposed(by: disposeBag)

        Observable
            .merge(onSearchModeEnable, onArtistSearch.map { $0.isEmpty })
            .filter { $0 }
            .compactMap { [weak self] _ in self?.searchHistoryService.searchHistory() }
            .bind(to: searchResults)
            .disposed(by: disposeBag)

        onArtistSearch
            .filter { !$0.isEmpty }
            .throttle(.seconds(1), scheduler: MainScheduler())
            .bind { [weak self] artist in
                self?.artistSearchService
                    .search(artist: artist)
                    .done { self?.searchResults.accept($0) }
                    .cauterize()
            }.disposed(by: disposeBag)

        onSearchItemSelected
            .map { $0.mbid }
            .bind(to: doShowArtistDetails)
            .disposed(by: disposeBag)

        onSearchItemSelected
            .map { [weak self] artistSearchMatch in
                self?.searchHistoryService.removeFromSearchHistory(artistSearchMatch.mbid)
                self?.searchHistoryService.addToSearchHistory(artistSearchMatch)
                return artistSearchMatch.mbid
            }.bind(to: doShowArtistDetails)
            .disposed(by: disposeBag)
    }
}
