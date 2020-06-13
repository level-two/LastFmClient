import RealmSwift

class ArtistSearchItemObject: Object {
    @objc dynamic var mbid: String = ""
    @objc dynamic var artist: String = ""

    required init() {
        super.init()
    }

    init(from artistSearchItem: ArtistSearchItem) {
        super.init()
        self.mbid = artistSearchItem.mbid
        self.artist = artistSearchItem.artist
    }

    var toArtistSearchItem: ArtistSearchItem {
        struct ArtistSearchItemImp: ArtistSearchItem {
            let mbid: String
            let artist: String
        }

        return ArtistSearchItemImp(mbid: mbid, artist: artist)
    }
}
