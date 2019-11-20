import RealmSwift

protocol DatabaseProvider {
    func getAlbum(with albumId: String) -> AlbumDatabaseObject?
    func storeAlbum(_ album: AlbumDatabaseObject)

    func isAlbumStored(albumId: String) -> Bool?
    func setAlbumStored(albumId: String, stored: Bool)

    func onAlbumUpdate(albumId: String, callback: @escaping () -> Void) -> NotificationToken?
}
