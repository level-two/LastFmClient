import UIKit
import RxSwift
import RxRelay
import PromiseKit

final class DefaultAlbumCardViewModel: AlbumCardViewModel {
    var mbid: String { return album.mbid }
    var artist: String { return album.artist }
    var title: String { return album.title }
    var onCover: Observable<UIImage?> { return cover.asObservable() }
    var onShowLoadingHud: Observable<Bool> { return showLoadingHud.asObservable() }
    var onStored: Observable<Bool> { return stored.asObservable() }
    var onStoreButton: AnyObserver<Void> { onStore.asObserver() }

    init(album: Album, imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService) {
        self.album = album
        self.imageDownloadService = imageDownloadService
        self.albumStoreService = albumStoreService
        self.stored = BehaviorRelay(value: albumStoreService.isAlbumStored(with: album.mbid))

        setupBindings()
    }
    func downloadContent() {
        downloadCoverImage(url: album.imageUrl[.medium])
    }

    private let album: Album

    private let onStore = PublishSubject<Void>()
    private let stored: BehaviorRelay<Bool>
    private let cover = BehaviorRelay<UIImage?>(value: nil)
    private let showLoadingHud = BehaviorRelay<Bool>(value: false)

    private let disposeBag = DisposeBag()

    private let imageDownloadService: ImageDownloadService
    private let albumStoreService: AlbumStoreService
}

private extension DefaultAlbumCardViewModel {

    func setupBindings() {
        albumStoreService.onAlbumStoredStateChange(with: album.mbid).bind(to: stored).disposed(by: disposeBag)

        onStore.bind { [weak self] in
            guard let self = self else { return }

            if self.albumStoreService.isAlbumStored(with: self.album.mbid) {
                self.albumStoreService.removeAlbum(with: self.album.mbid)
            } else {
                self.albumStoreService.storeAlbum(self.album)
            }
        }.disposed(by: disposeBag)
    }

    func downloadCoverImage(url: String?) {
        showLoadingHud.accept(true)

        firstly {
            self.imageDownloadService.getImage(url)
        }.done { [weak self] image in
            self?.cover.accept(image)
        }.catch { [weak self] _ in
            self?.cover.accept(UIImage(named: "noImage"))
        }.finally { [weak self] in
            self?.showLoadingHud.accept(false)
        }
    }
}
