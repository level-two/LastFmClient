import RealmSwift

class AlbumObject: Object, Album {
    dynamic var mbid: String = ""
    dynamic var title: String = ""
    dynamic var artist: String = ""
    var albumTracks = List<AlbumTrack>()
    var albumImageUrl = List<AlbumImageUrlObject>()

    var tracks: [Track] {
        get { Array(albumTracks) }
        set {
            albumTracks.removeAll()
            albumTracks.append(objectsIn: newValue.map(AlbumTrack.init))
        }
    }

    var imageUrl: [ImageSize: String] {
        get {
            var dic = [ImageSize: String]()
            albumImageUrl.forEach { dic[$0.imageSize] = $0.imageUrl }
            return dic
        }
        set {
            albumImageUrl.removeAll()
            albumImageUrl.append(objectsIn: newValue.map(AlbumImageUrlObject.init))
        }
    }

    required init() {
        super.init()
    }

    init(from album: Album) {
        super.init()
        self.mbid = album.mbid
        self.title = album.title
        self.artist = album.artist
        self.imageUrl = album.imageUrl
        self.tracks = album.tracks
    }
}
