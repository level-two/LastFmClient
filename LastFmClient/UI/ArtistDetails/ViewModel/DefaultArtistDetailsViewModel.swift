import UIKit
import RxSwift
import RxRelay
import PromiseKit

class DefaultArtistDetailsViewModel: ArtistDetailsViewModel {
    var artistDetails: Observable<ArtistDetailsCellViewModel> { artistDetailsVar.asObservable() }
    var albums: Observable<[AlbumCardViewModel]> { albumsVar.asObservable() }

    var showHud: Observable<Bool> { doShowHud.asObservable() }
    var showNetworkError: Observable<Void> { doShowNetworkError.asObservable() }
    var doActionOnNetworkError: AnyObserver<NetworkErrorAction> { actionOnNetworkError.asObserver() }

    var doShowFullBio: AnyObserver<Void> { onShowArtistFullBio.asObserver() }
    var showFullBio: Observable<String> { doShowArtistFullBio.asObservable() }

    var doShowAlbumDetails: AnyObserver<Int> { onShowArtistAlbumDetails.asObserver() }
    var showAlbumDetails: Observable<String> { doShowArtistAlbumDetails.asObservable() }

    var doGoBack: AnyObserver<Void> { onBack.asObserver() }
    var showMainScreen: Observable<Void> { doShowMainScreen.asObservable() }

    private let artistDetailsVar = PublishRelay<ArtistDetailsCellViewModel>()
    private let albumsVar = BehaviorRelay<[AlbumCardViewModel]>(value: [])

    private let doShowHud = PublishSubject<Bool>()
    private let doShowNetworkError = PublishSubject<Void>()
    private let actionOnNetworkError = PublishSubject<NetworkErrorAction>()

    private let onShowArtistFullBio = PublishSubject<Void>()
    private let doShowArtistFullBio = PublishRelay<String>()

    private let onShowArtistAlbumDetails = PublishSubject<Int>()
    private let doShowArtistAlbumDetails = PublishRelay<String>()

    private let onBack = PublishSubject<Void>()
    private let doShowMainScreen = PublishRelay<Void>()

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
        setupDataBindings()
        setupNavigationBindings()
    }

    func setupDataBindings() {
//        Observable
//            .merge(.just(()), actionOnNetworkError.filter { $0 == .retry }.map { _ in })
//            .bind { [weak self] in
//                self?.loadData()
//
//
//
//                // Load data
//            }.disposed(by: disposeBag)
    }

    func setupNavigationBindings() {

    }
}

private extension DefaultArtistDetailsViewModel {
    func loadData() {
        Observable
            .merge(.just(()),
                   actionOnNetworkError.filter { $0 == .retry }.map { _ in })
            .bind { [weak self] in
                self?.doShowHud.onNext(true)
                firstly {
                    self?.loadAlbums() ?? .failed
                }.then {
                    self?.loadArtistInfo() ?? .failed
                }.ensure {
                    self?.doShowHud.onNext(false)
                }.catch { _ in
                    self?.doShowNetworkError.onNext(())
                }
            }.disposed(by: disposeBag)
    }

    func loadAlbums() -> Promise<Void> {
        return artistInfoService
            .getTopAlbums(mbid: mbid)
            .map { [weak self] albums in
                guard let self = self else { return }

                let cards = albums.map {
                    DefaultAlbumCardViewModel(album: $0,
                                              imageDownloadService: self.imageDownloadService,
                                              albumStoreService: self.albumStoreService)
                }

                self.albumsVar.accept(cards)
        }
    }

    func loadArtistInfo() -> Promise<Void> {
        return artistInfoService
            .getInfo(mbid: mbid)
            .map { [weak self] _ in
                let details = DefaultArtistDetailsCellViewModel.mock()
                self?.artistDetailsVar.accept(details)
            }
    }

}
