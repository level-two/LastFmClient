import RealmSwift

class AlbumObject: Object {
    @objc dynamic var mbid: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var artist: String = ""
    var albumTracks = List<TrackObject>()
    var albumImageUrl = List<ImageUrlObject>()

    required init() {
        super.init()
    }

    init(from album: Album) {
        super.init()
        self.mbid = album.mbid
        self.title = album.title
        self.artist = album.artist
        self.albumImageUrl.append(objectsIn: album.imageUrl.map(ImageUrlObject.init))
        self.albumTracks.append(objectsIn: album.tracks.map(TrackObject.init))
    }

    var toAlbum: Album {
        struct AlbumImp: Album {
            let mbid: String
            let title: String
            let artist: String
            let imageUrl: [ImageSize: String]
            let tracks: [Track]
        }

        let tracks = Array(albumTracks.map { $0.toTrack })
        let imageUrl = Dictionary(albumImageUrl.map { $0.toImageUrl }, uniquingKeysWith: { _, new in new })

        return AlbumImp(mbid: mbid, title: title, artist: artist, imageUrl: imageUrl, tracks: tracks)
    }
}
