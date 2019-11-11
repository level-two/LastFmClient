import UIKit

struct TrackModel {
    var rank: Int
    var name: String
    var artist: String
    var duration: Int

    init(from trackInfo: NetworkService.Album.TrackInfoResponse) {
        self.rank = trackInfo.rank
        self.name = trackInfo.name
        self.artist = trackInfo.artist
        self.duration = trackInfo.duration
    }

    init(from trackObject: TrackDatabaseObject) {
        self.rank = trackObject.rank
        self.name = trackObject.name
        self.artist = trackObject.artist
        self.duration = trackObject.duration
    }
}

struct AlbumDetailsModel {
    var title: String
    var artist: String
    var year: String
    var coverImage: UIImage?
    var tracks: [TrackModel]

    init(from albumInfo: NetworkService.Album.AlbumInfoResponse) {
        self.title = albumInfo.name
        self.artist = albumInfo.artist
        self.year = albumInfo.releaseDate
        self.tracks = albumInfo.tracks.map(TrackModel.init)
    }

    init(from albumObject: AlbumDatabaseObject) {
        self.title = albumObject.name
        self.artist = albumObject.artist

        if let releaseDate = albumObject.releaseDate {
            let year = Calendar.current.component(.year, from: releaseDate)
            self.year = "\(year)"
        } else {
            self.year = ""
        }

        self.tracks = albumObject.tracks.map(TrackModel.init)
    }
}
