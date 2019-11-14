import RealmSwift

protocol DatabaseProvider {
    func getAlbum(with albumId: String) -> AlbumDatabaseObject?
    func storeAlbum(_ album: AlbumDatabaseObject)

    func getAlbumState(for albumId: String) -> AlbumStateDatabaseObject?
    func storeAlbumState(_ albumState: AlbumStateDatabaseObject)
    func isAlbumStored(albumId: String) -> Bool?
    func setAlbumStored(albumId: String, stored: Bool)

    func onAlbumStateUpdate(albumId: String, callback: @escaping () -> Void) -> NotificationToken?
}
