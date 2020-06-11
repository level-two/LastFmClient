import RxSwift
import RxRelay

final class DefaultHomeScreenViewModel: HomeScreenViewModel {
    var onStoredAlbums: Observable<[AlbumCardViewModel]> {
        return storedAlbums.asObservable()
    }

    var onShowAlbumDetails: Observable<String> {
        return doShowAlbumDetails.asObservable()
    }

    var doSelectCard: AnyObserver<Int> {
        return onCardSelected.asObserver()
    }

    var doSearchModeEnable: AnyObserver<Bool> {
        return onSearchModeEnable.asObserver()
    }

    var doArtistSearch: AnyObserver<String> {
       return onArtistSearch.asObserver()
   }

    var onSearchResults: Observable<[ArtistSearchViewModel]> {
        return searchResults.asObservable()
    }

    var doSelectSearchItem: AnyObserver<ArtistSearchViewModel> {
        return onSearchItemSelected.asObserver()
    }

    var onShowArtistDetails: Observable<String> {
        return doShowArtistDetails.asObservable()
    }

    init(imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService) {
        self.imageDownloadService = imageDownloadService
        self.albumStoreService = albumStoreService

        setupBindings()
        //makeMock()
    }

    private let storedAlbums = BehaviorRelay<[AlbumCardViewModel]>(value: [])
    private let doShowAlbumDetails = BehaviorRelay<String>(value: "")
    private let onCardSelected = PublishSubject<Int>()

    private let onSearchModeEnable = PublishSubject<Bool>()
    private let onArtistSearch = PublishSubject<String>()

    private let searchResults = BehaviorRelay<[ArtistSearchViewModel]>(value: [])
    private let onSearchItemSelected = PublishSubject<ArtistSearchViewModel>()
    private let doShowArtistDetails = BehaviorRelay<String>(value: "")

    private let imageDownloadService: ImageDownloadService
    private let albumStoreService: AlbumStoreService

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
            // .map { databaseService.getSearchHistory() }
            .map { _ in [DefaultArtistSearchViewModel(mbid: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0", artist: "Golova")] }
            .bind(to: searchResults)
            .disposed(by: disposeBag)

        onArtistSearch
            .filter { !$0.isEmpty }
            .throttle(.seconds(1), scheduler: MainScheduler())
            .map { _ in [DefaultArtistSearchViewModel(mbid: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0", artist: "Golova")] }
            .bind(to: searchResults)
            .disposed(by: disposeBag)

        onSearchItemSelected
            .map { $0.mbid }
            .bind(to: doShowArtistDetails)
            .disposed(by: disposeBag)

        onSearchItemSelected
            .map { [weak self] searchResult in
                // delete repeating element if exists
                // store to the search history
                return searchResult.mbid
            }.bind(to: doShowArtistDetails)
            .disposed(by: disposeBag)

    }

    func makeMock() {
        DispatchQueue.global(qos: .background).async {
            stride(from: 0, to: 100, by: 1).forEach { [weak self] idx in
                struct MockAlbum: Album {
                    let mbid: String
                    let title: String
                    let artist: String
                    let imageUrl: [ImageSize: String]
                    let mockTracks: [MockTrack]

                    var tracks: [Track] {
                        return mockTracks
                    }
                }

                struct MockTrack: Track {
                    var rank: Int
                    var name: String
                    var artist: String
                    var duration: Int
                }

                let mockAlbum = MockAlbum(
                    mbid: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0-\(idx)",
                    title: "Album Title \(idx)",
                    artist: "Supa Artist",
                    imageUrl: [.medium: "https://habrastorage.org/webt/mr/u7/wu/mru7wusyxtgjbaptshr3o5olipu.png"],
                    mockTracks: [])

                self?.albumStoreService.storeAlbum(mockAlbum)
            }
        }
    }
}
