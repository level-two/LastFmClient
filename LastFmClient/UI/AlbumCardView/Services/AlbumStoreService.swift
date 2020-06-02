
protocol AlbumStoreService {
    func isAlbumStored(mbid: String) -> Bool
    func storeAlbum(mbid: String)
    func onAlbumStoredStateChange(mbid: String, callback: @escaping (Bool) -> Void)
}
