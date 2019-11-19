import UIKit

struct HomeScreenAlbumViewModel {
    let cover: UIImage?
    let title: String
    let year: String
    let tracksNumber: Int
    let isAlbumInCollection: Bool

    static var mock: HomeScreenAlbumViewModel {
        return .init(
            cover: UIImage(named: "Golova"),
            title: "Golova",
            year: "2013",
            tracksNumber: 13,
            isAlbumInCollection: true)
    }
}
