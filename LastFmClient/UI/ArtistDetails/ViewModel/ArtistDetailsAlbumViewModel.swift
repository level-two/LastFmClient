import UIKit

struct ArtistDetailsAlbumViewModel {
    let cover: UIImage?
    let title: String
    let year: String
    let tracksNumber: Int
    let isAlbumInCollection: Bool

    static var mock: ArtistDetailsAlbumViewModel {
        return .init(
            cover: UIImage(named: "Golova"),
            title: "Golova",
            year: "2013",
            tracksNumber: 13,
            isAlbumInCollection: true)
    }
}
