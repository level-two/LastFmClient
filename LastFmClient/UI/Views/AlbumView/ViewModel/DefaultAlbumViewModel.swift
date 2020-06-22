import UIKit
import RxSwift
import RxRelay
import PromiseKit

final class DefaultAlbumViewModel: AlbumViewModel {
    var mbid: String { return album.mbid }
    var artist: String { return album.artist }
    var title: String { return album.title }
    var onCover: Observable<UIImage?> { return cover.asObservable() }
    var showHud: Observable<Bool> { return doShowHud.asObservable() }

    init(album: Album, imageDownloadService: ImageDownloadService) {
        self.album = album
        self.imageDownloadService = imageDownloadService
        downloadCoverImage()
    }

    private let album: Album
    private let cover = BehaviorRelay<UIImage?>(value: nil)
    private let doShowHud = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    private let imageDownloadService: ImageDownloadService
}

private extension DefaultAlbumViewModel {
    func downloadCoverImage() {
        doShowHud.accept(true)

        let url = album.imageUrl[.large]

        firstly {
            self.imageDownloadService.getImage(url)
        }.done { [weak self] image in
            self?.cover.accept(image)
        }.catch { [weak self] _ in
            self?.cover.accept(UIImage(named: "noImage"))
        }.finally { [weak self] in
            self?.doShowHud.accept(false)
        }
    }
}
