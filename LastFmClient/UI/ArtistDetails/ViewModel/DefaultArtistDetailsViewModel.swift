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

import UIKit
import RxSwift
import RxRelay
import PromiseKit

class DefaultArtistDetailsViewModel: ArtistDetailsViewModel {
    var artistDetails: ArtistDetailsCellViewModel?
    var albums: [AlbumCardViewModel] = []
    var contentIsReady: Observable<Bool> { onContentReady.asObservable() }

    var showHud: Observable<Bool> { doShowHud.asObservable() }
    var showNetworkError: Observable<NetworkErrorOverlayInteractor?> { doShowNetworkError.asObservable() }

    var doShowFullBio: AnyObserver<Void> { onShowArtistFullBio.asObserver() }
    var showFullBio: Observable<String> { doShowArtistFullBio.asObservable() }
    var doShowAlbumDetails: AnyObserver<Int> { onShowArtistAlbumDetails.asObserver() }
    var showAlbumDetails: Observable<String> { doShowArtistAlbumDetails.asObservable() }

    private let onContentReady = BehaviorSubject<Bool>(value: false)

    private let doShowHud = BehaviorRelay<Bool>(value: false)
    private let doShowNetworkError = BehaviorRelay<NetworkErrorOverlayInteractor?>(value: nil)
    private let onRetry = PublishSubject<Void>()

    private let onShowArtistFullBio = PublishSubject<Void>()
    private let doShowArtistFullBio = PublishRelay<String>()
    private let onShowArtistAlbumDetails = PublishSubject<Int>()
    private let doShowArtistAlbumDetails = PublishRelay<String>()

    private let disposeBag = DisposeBag()

    private let imageDownloadService: ImageDownloadService
    private let artistInfoService: ArtistInfoService
    private let albumStoreService: AlbumStoreService

    private let mbid: String

    init(imageDownloadService: ImageDownloadService,
         artistInfoService: ArtistInfoService,
         albumStoreService: AlbumStoreService,
         artistMbid: String) {

        self.imageDownloadService = imageDownloadService
        self.artistInfoService = artistInfoService
        self.albumStoreService = albumStoreService

        self.mbid = artistMbid

        setupBindings()
        loadData()
    }
}

private extension DefaultArtistDetailsViewModel {
    func setupBindings() {
        onShowArtistFullBio
            .compactMap { [weak self] in self?.artistDetails?.longDescription }
            .bind(to: doShowArtistFullBio)
            .disposed(by: disposeBag)

        onShowArtistAlbumDetails
            .compactMap { [weak self] index in self?.albums[safe: index]?.album.mbid }
            .bind(to: doShowArtistAlbumDetails)
            .disposed(by: disposeBag)
    }
}

private extension DefaultArtistDetailsViewModel {
    func loadData() {
        Observable
            .merge(.just(()), onRetry)
            .bind { [weak self] in

                self?.doShowNetworkError.accept(nil)
                self?.doShowHud.accept(true)

                firstly {
                    self?.loadAlbums() ?? .failed
                }.then {
                    self?.loadArtistInfo() ?? .failed
                }.ensure {
                    self?.onContentReady.onNext(true)
                    self?.doShowHud.accept(false)
                }.catch { _ in
                    guard let self = self else { return }
                    let interactor = DefaultNetworkErrorOverlayInteractor(retry: self.onRetry.asObserver())
                    self.doShowNetworkError.accept(interactor)
                }

            }.disposed(by: disposeBag)
    }

    func loadAlbums() -> Promise<Void> {
        return artistInfoService
            .topAlbums(mbid: mbid)
            .map { [weak self] albums in
                guard let self = self else { return }

                self.albums = albums.map { album in
                    DefaultAlbumCardViewModel(album: album,
                                              imageDownloadService: self.imageDownloadService,
                                              albumStoreService: self.albumStoreService)
                }
        }
    }

    func loadArtistInfo() -> Promise<Void> {
        return artistInfoService
            .artistInfo(mbid: mbid)
            .map { [weak self] artist in
                guard let self = self else { return }

                self.artistDetails =
                    DefaultArtistDetailsCellViewModel(artist: artist,
                                                      imageDownloadService: self.imageDownloadService)
            }
    }

}
