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
import RxCocoa
import RxRelay
import PromiseKit

final class DefaultAlbumDetailsViewModel: AlbumDetailsViewModel {
    var albumDetails: AlbumViewModel?
    var tracks: [AlbumDetailsTrackCellViewModel]?
    var albumStore: AlbumStoreViewModel?

    var contentIsReady: Observable<Bool> { onContentReady.asObservable() }

    var showHud: Observable<Bool> { doShowHud.asObservable() }
    var showNetworkError: Observable<NetworkErrorOverlayInteractor?> { doShowNetworkError.asObservable() }

    init(mbid: String,
         imageDownloadService: ImageDownloadService,
         albumInfoService: AlbumInfoService,
         albumStoreService: AlbumStoreService) {

        self.albumInfoService = albumInfoService
        self.imageDownloadService = imageDownloadService
        self.albumStoreService = albumStoreService

        loadData(mbid: mbid)
    }

    private let onContentReady = BehaviorRelay<Bool>(value: false)
    private let doShowHud = BehaviorRelay<Bool>(value: false)
    private let doShowNetworkError = BehaviorRelay<NetworkErrorOverlayInteractor?>(value: nil)
    private let onRetry = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    private let albumInfoService: AlbumInfoService
    private let imageDownloadService: ImageDownloadService
    private let albumStoreService: AlbumStoreService
}

private extension DefaultAlbumDetailsViewModel {
    func loadData(mbid: String) {
        Observable
            .merge(.just(()), onRetry)
            .bind { [weak self] in

                self?.doShowNetworkError.accept(nil)
                self?.doShowHud.accept(true)

                firstly {
                    self?.albumInfoService.albumInfo(mbid: mbid) ?? .failed
                }.done { album in
                    guard let self = self else { return }
                    self.albumDetails = DefaultAlbumViewModel(album: album,
                                                              imageDownloadService: self.imageDownloadService)
                    self.albumStore = DefaultAlbumStoreViewModel(album: album,
                                                                 albumStoreService: self.albumStoreService)
                    self.tracks = album.tracks.map(DefaultAlbumDetailsTrackCellViewModel.init)
                    self.onContentReady.accept(true)
                }.ensure {
                    self?.doShowHud.accept(false)
                }.catch { _ in
                    guard let self = self else { return }
                    let interactor = DefaultNetworkErrorOverlayInteractor(retry: self.onRetry.asObserver())
                    self.doShowNetworkError.accept(interactor)
                }

            }.disposed(by: disposeBag)
    }
}
