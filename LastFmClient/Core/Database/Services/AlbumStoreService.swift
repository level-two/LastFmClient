import RxSwift

protocol AlbumStoreService {
    func storeAlbum(_ album: Album)
    func removeAlbum(with mbid: String)
    func getAlbum(with mbid: String) -> Album?
    func isAlbumStored(with mbid: String) -> Bool
    func onAlbumStoredStateChange(with mbid: String) -> Observable<Bool>
    func storedAlbums() -> Observable<[Album]>
}
