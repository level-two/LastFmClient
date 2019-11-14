import RealmSwift

class AlbumDatabaseObject: Object {
    @objc dynamic var albumId = ""
    @objc dynamic var name = ""
    @objc dynamic var artist = ""
    @objc dynamic var releaseDate: Date?
    var tracks = List<TrackDatabaseObject>()
    @objc dynamic var imageUrl: String = ""
}
