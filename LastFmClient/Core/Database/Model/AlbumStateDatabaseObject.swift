import RealmSwift

// FIXME: move isStored to the album database object

class AlbumStateDatabaseObject: Object {
    @objc dynamic var albumId = ""
    @objc dynamic var isStored = false
}
