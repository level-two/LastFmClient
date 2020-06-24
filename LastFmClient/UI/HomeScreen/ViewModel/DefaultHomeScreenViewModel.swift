// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

import RxSwift
import RxRelay
import PromiseKit

final class DefaultHomeScreenViewModel: HomeScreenViewModel {
    var onStoredAlbums: Observable<[AlbumCardViewModel]> { storedAlbums.asObservable() }
    var onShowAlbumDetails: Observable<String> { doShowAlbumDetails.asObservable() }
    var doSelectCard: AnyObserver<AlbumCardViewModel> { onCardSelected.asObserver() }

    var doArtistSearch: AnyObserver<String> { onArtistSearch.asObserver() }

    var onSearchResults: Observable<[ArtistSearchItem]> { searchResults.asObservable() }
    var doSelectSearchItem: AnyObserver<ArtistSearchItem> { onSearchItemSelected.asObserver() }
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
    private let doShowAlbumDetails = PublishRelay<String>()
    private let onCardSelected = PublishSubject<AlbumCardViewModel>()

    private let onArtistSearch = PublishSubject<String>()

    private let searchResults = BehaviorRelay<[ArtistSearchItem]>(value: [])
    private let onSearchItemSelected = PublishSubject<ArtistSearchItem>()
    private let doShowArtistDetails = PublishRelay<String>()

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
        let searchHistoryService = self.searchHistoryService
        let artistSearchService = self.artistSearchService

        albumStoreService.storedAlbums()
            .map { storedAlbums in
                storedAlbums
                    .reversed()
                    .map { album in
                        DefaultAlbumCardViewModel(album: album,
                                                  imageDownloadService: imageDownloadService,
                                                  albumStoreService: albumStoreService)
                    }
            }
            .bind(to: storedAlbums)
            .disposed(by: disposeBag)

        onCardSelected
            .map { $0.album.mbid }
            .bind(to: doShowAlbumDetails)
            .disposed(by: disposeBag)

        onArtistSearch
            .filter { $0.isEmpty }
            .compactMap { _ in searchHistoryService.searchHistory() }
            .map { $0.reversed() }
            .bind(to: searchResults)
            .disposed(by: disposeBag)

        onArtistSearch
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .bind { [weak self] artist in
                artistSearchService
                    .search(artist: artist)
                    .done { self?.searchResults.accept($0) }
                    .cauterize()
            }.disposed(by: disposeBag)

        onSearchItemSelected
            .map { artistSearchItem in
                searchHistoryService.removeFromSearchHistory(artistSearchItem.mbid)
                searchHistoryService.addToSearchHistory(artistSearchItem)
                return artistSearchItem.mbid
            }.bind(to: doShowArtistDetails)
            .disposed(by: disposeBag)
    }
}
