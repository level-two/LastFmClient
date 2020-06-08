import RealmSwift

class AlbumTrack: Object, Track {
    dynamic var rank: Int = 0
    dynamic var name: String = ""
    dynamic var artist: String = ""
    dynamic var duration: Int = 0

    required init() {
        super.init()
    }

    init(from track: Track) {
        super.init()
        self.rank = track.rank
        self.name = track.name
        self.artist = track.artist
        self.duration = track.duration
    }
}
