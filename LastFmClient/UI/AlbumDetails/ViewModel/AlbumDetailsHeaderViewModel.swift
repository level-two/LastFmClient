import UIKit

struct AlbumDetailsHeaderViewModel {
    var cover: UIImage?
    var title: String
    var artist: String
    var year: String

    init(from albumData: AlbumDetailsModel) {
        self.cover = albumData.coverImage ?? UIImage(named: "AlbumEmptyCover")
        self.title = albumData.title
        self.artist = albumData.artist
        self.year = albumData.year
    }
}
