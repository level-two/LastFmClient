import UIKit
import RxSwift
import RxRelay
import PromiseKit

final class DefaultArtistDetailsCellViewModel: ArtistDetailsCellViewModel {
    let mbid: String
    let name: String
    let shortDescription: String
    let longDescription: String

    var artistPhoto: Observable<UIImage?> { onArtistPhoto.asObservable() }
    var showLoadingHud: Observable<Bool> { doShowLoadingHud.asObservable() }

    private let onArtistPhoto = BehaviorRelay<UIImage?>(value: nil)
    private let doShowLoadingHud = PublishRelay<Bool>()

    private let imageDownloadService: ImageDownloadService

    init(artist: Artist, imageDownloadService: ImageDownloadService) {
        self.mbid = artist.mbid
        self.name = artist.name
        self.shortDescription = artist.bio.summary
        self.longDescription = artist.bio.content
        self.imageDownloadService = imageDownloadService

        downloadCoverImage(url: artist.imageUrl[.large])
    }
}

private extension DefaultArtistDetailsCellViewModel {
    func downloadCoverImage(url: String?) {
        doShowLoadingHud.accept(true)

        firstly {
            self.imageDownloadService.getImage(url)
        }.done { [weak self] image in
            self?.onArtistPhoto.accept(image)
        }.catch { [weak self] _ in
            self?.onArtistPhoto.accept(UIImage(named: "noPhoto"))
        }.finally { [weak self] in
            self?.doShowLoadingHud.accept(false)
        }
    }
}
