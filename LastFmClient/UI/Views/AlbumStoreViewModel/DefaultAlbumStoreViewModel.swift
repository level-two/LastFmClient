import RxSwift
import RxRelay
import PromiseKit

final class DefaultAlbumStoreViewModel: AlbumStoreViewModel {
    var stored: Observable<Bool> { return onStored.asObservable() }
    var store: AnyObserver<Void> { doStore.asObserver() }

    init(album: Album, albumStoreService: AlbumStoreService) {
        self.album = album
        self.albumStoreService = albumStoreService
        self.onStored = BehaviorRelay(value: albumStoreService.isAlbumStored(with: album.mbid))
        setupBindings()
    }

    private let album: Album
    private let onStored: BehaviorRelay<Bool>
    private let doStore = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    private let albumStoreService: AlbumStoreService
}

private extension DefaultAlbumStoreViewModel {

    func setupBindings() {
        albumStoreService
            .onAlbumStoredStateChange(with: album.mbid)
            .bind(to: onStored)
            .disposed(by: disposeBag)

        doStore.bind { [weak self] in
            guard let self = self else { return }

            if self.albumStoreService.isAlbumStored(with: self.album.mbid) {
                self.albumStoreService.removeAlbum(with: self.album.mbid)
            } else {
                self.albumStoreService.storeAlbum(self.album)
            }
        }.disposed(by: disposeBag)
    }
}
