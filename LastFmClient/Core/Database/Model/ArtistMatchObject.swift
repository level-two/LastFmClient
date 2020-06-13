import RealmSwift

class ArtistSearchItemObject: Object {
    @objc dynamic var mbid: String = ""
    @objc dynamic var artist: String = ""

    required init() {
        super.init()
    }

    init(from artistMatch: ArtistSearchMatch) {
        super.init()
        self.mbid = artistMatch.mbid
        self.artist = artistMatch.artist
    }

    var toArtistSearchMatch: ArtistSearchMatch {
        struct ArtistSearchMatchCopy: ArtistSearchMatch {
            let mbid: String
            let artist: String
        }

        return ArtistSearchMatchCopy(mbid: mbid, artist: artist)
    }
}
