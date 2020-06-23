import UIKit
import RxSwift
import RxRelay
import PromiseKit

class DefaultArtistDetailsViewModel: ArtistDetailsViewModel {
    var artistDetails: Observable<[ArtistDetailsCellViewModel]> { artistDetailsVar.asObservable() }
    var albums: Observable<[AlbumCardViewModel]> { albumsVar.asObservable() }

    var showHud: Observable<Bool> { doShowHud.asObservable() }
    var showNetworkError: Observable<NetworkErrorOverlayInteractor?> { doShowNetworkError.asObservable() }

    var doShowFullBio: AnyObserver<Int> { onShowArtistFullBio.asObserver() }
    var showFullBio: Observable<String> { doShowArtistFullBio.asObservable() }
    var doShowAlbumDetails: AnyObserver<Int> { onShowArtistAlbumDetails.asObserver() }
    var showAlbumDetails: Observable<String> { doShowArtistAlbumDetails.asObservable() }

    private let artistDetailsVar = BehaviorRelay<[ArtistDetailsCellViewModel]>(value: [])
    private let albumsVar = BehaviorRelay<[AlbumCardViewModel]>(value: [])

    private let doShowHud = PublishSubject<Bool>()
    private let doShowNetworkError = PublishSubject<NetworkErrorOverlayInteractor?>()
    private let onRetry = PublishSubject<Void>()

    private let onShowArtistFullBio = PublishSubject<Int>()
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
            .compactMap { [weak self] index in self?.artistDetailsVar.value[safe: index]?.longDescription }
            .bind(to: doShowArtistFullBio)
            .disposed(by: disposeBag)

        onShowArtistAlbumDetails
            .compactMap { [weak self] index in self?.albumsVar.value[safe: index]?.album.mbid }
            .bind(to: doShowArtistAlbumDetails)
            .disposed(by: disposeBag)
    }
}

private extension DefaultArtistDetailsViewModel {
    func loadData() {
        Observable
            .merge(.just(()), onRetry)
            .bind { [weak self] in

                self?.doShowNetworkError.onNext(nil)
                self?.doShowHud.onNext(true)

                firstly {
                    self?.loadAlbums() ?? .failed
                }.then {
                    self?.loadArtistInfo() ?? .failed
                }.ensure {
                    self?.doShowHud.onNext(false)
                }.catch { _ in
                    guard let self = self else { return }
                    let interactor = DefaultNetworkErrorOverlayInteractor(retry: self.onRetry.asObserver())
                    self.doShowNetworkError.onNext(interactor)
                }

            }.disposed(by: disposeBag)
    }

    func loadAlbums() -> Promise<Void> {
        return artistInfoService
            .topAlbums(mbid: mbid)
            .map { [weak self] albums in
                guard let self = self else { return }

                let cards = albums.map { album in
                    DefaultAlbumCardViewModel(album: album,
                                              imageDownloadService: self.imageDownloadService,
                                              albumStoreService: self.albumStoreService)
                }

                self.albumsVar.accept(cards)
        }
    }

    func loadArtistInfo() -> Promise<Void> {
        return artistInfoService
            .artistInfo(mbid: mbid)
            .map { [weak self] artist in
                guard let self = self else { return }
                let details = DefaultArtistDetailsCellViewModel(artist: artist,
                                                                imageDownloadService: self.imageDownloadService)
                self.artistDetailsVar.accept([details])
            }
    }

}
