import UIKit

struct TrackModel {
    var rank: Int
    var name: String
    var artist: String
    var duration: Int

    init(from trackInfo: NetworkService.Album.TrackInfo) {
        self.rank = trackInfo.rank
        self.name = trackInfo.name
        self.artist = trackInfo.artist
        self.duration = trackInfo.duration
    }
}

struct AlbumDetailsModel {
    var title: String
    var artist: String
    var year: String
    var coverImage: UIImage?
    var tracks: [TrackModel]

    init(from albumInfo: NetworkService.Album.AlbumInfo) {
        self.title = albumInfo.name
        self.artist = albumInfo.artist
        self.year = albumInfo.releasedate
        self.tracks = albumInfo.tracks.map(TrackModel.init)
    }
}
