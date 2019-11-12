import UIKit

struct TrackModel {
//    var rank: Int
    var name: String
    var artist: String
    var duration: Int

    init(from track: AlbumInfoResponse.Track) {
//        self.rank = trackInfo.rank
        self.name = track.name
        self.artist = track.artist.name
        self.duration = Int(track.duration) ?? 0
    }

    init(from trackObject: TrackDatabaseObject) {
//        self.rank = trackObject.rank
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

    init(from albumInfo: AlbumInfoResponse) {
        self.title = albumInfo.album.name
        self.artist = albumInfo.album.artist
        self.year = "1999 STUB" // albumInfo.album.releaseDate
        self.tracks = albumInfo.album.tracks.track.map(TrackModel.init)
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
