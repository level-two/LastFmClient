import RealmSwift

class AlbumTrack: Object, Track {
    @objc dynamic var rank: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var artist: String = ""
    @objc dynamic var duration: Int = 0

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
