import UIKit
import RxSwift
import RxRelay
import PromiseKit

class DefaultAlbumCardViewModel: AlbumCardViewModel {
    typealias Service = ImageDownloadService & AlbumStoreService

    var artist: String { return album.artist }
    var title: String { return album.title }
    var onCover: Observable<UIImage?> { return cover.asObservable() }
    var onShowLoadingHud: Observable<Bool> { return showLoadingHud.asObservable() }
    var onStored: Observable<Bool> { return stored.asObservable() }

    init(album: Album, service: Service) {
        self.album = album
        self.service = service
        self.stored = BehaviorRelay(value: service.isAlbumStored(with: album.mbid))
        setupBindings()
    }

    var onStoreButton: AnyObserver<()> {
        onStore.asObserver()
    }

    func downloadContent() {
        downloadCoverImage(url: album.imageUrl[.medium])
    }

    private let album: Album
    private let onStore = BehaviorSubject<Void>(value: ())
    private let stored: BehaviorRelay<Bool>
    private let cover = BehaviorRelay<UIImage?>(value: nil)
    private let showLoadingHud = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    private let service: Service
}

private extension DefaultAlbumCardViewModel {

    func setupBindings() {
        service.onAlbumStoredStateChange(with: album.mbid).bind(to: stored).disposed(by: disposeBag)

        onStore.bind { [weak self] in
            guard let self = self else { return }

            if self.service.isAlbumStored(with: self.album.mbid) {
                self.service.removeAlbum(with: self.album.mbid)
            } else {
                self.service.storeAlbum(self.album)
            }
        }.disposed(by: disposeBag)
    }

    func downloadCoverImage(url: String?) {
        showLoadingHud.accept(true)

        firstly {
            self.service.getImage(url: url ?? "")
        }.done { [weak self] image in
            self?.cover.accept(image)
        }.catch { [weak self] _ in
            self?.cover.accept(UIImage(named: "noimage"))
        }.finally { [weak self] in
            self?.showLoadingHud.accept(false)
        }
    }
}
