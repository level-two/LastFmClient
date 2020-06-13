import RealmSwift
import RxSwift

class RealmDatabaseService: DatabaseService { }

// MARK: - AlbumStoreService conformance
extension RealmDatabaseService {
    func storeAlbum(_ album: Album) {
        let realm = Realm.default
        let albumObject = AlbumObject(from: album)

        do {
            try realm.write { realm.add(albumObject) }
        } catch {
            fatalError("Failed to store album to realm: \(error)")
        }
    }

    func removeAlbum(with mbid: String) {
        let realm = Realm.default

        guard let albumObject = realm.objects(AlbumObject.self).first(where: { $0.mbid == mbid }) else { return }

        do {
            try realm.write { realm.delete(albumObject) }
        } catch {
            fatalError("Failed to store album to realm: \(error)")
        }
    }

    func getAlbum(with mbid: String) -> Album? {
        return Realm.default
            .objects(AlbumObject.self)
            .first { $0.mbid == mbid }
            .map { $0.toAlbum }
    }

    func isAlbumStored(with mbid: String) -> Bool {
        return Realm.default
            .objects(AlbumObject.self)
            .contains { $0.mbid == mbid }
    }

    func onAlbumStoredStateChange(with mbid: String) -> Observable<Bool> {
        return Realm.default
            .objects(AlbumObject.self)
            .filter("mbid == '\(mbid)'")
            .asObservable
            .map { !$0.isEmpty }
    }

    func storedAlbums() -> Observable<[Album]> {
        return Realm.default
        .objects(AlbumObject.self)
        .asObservable
        .map { $0.map { $0.toAlbum } }
    }
}

// MARK: - ArtistSearchHistoryService conformance
extension RealmDatabaseService {
    func addToSearchHistory(_ artistSearchItem: ArtistSearchItem) {
        let realm = Realm.default
        let artistSearchItemObject = ArtistSearchItemObject(from: artistSearchItem)

        do {
            try realm.write { realm.add(artistSearchItemObject) }
        } catch {
            fatalError("Failed to store album to realm: \(error)")
        }
    }

    func removeFromSearchHistory(_ mbid: String) {
        let realm = Realm.default
        let artistSearchItemObjects = realm.objects(ArtistSearchItemObject.self).filter("mbid == '\(mbid)'")
        do {
            try realm.write { realm.delete(artistSearchItemObjects) }
        } catch {
            fatalError("Failed to store album to realm: \(error)")
        }
   }

    func searchHistory() -> [ArtistSearchItem] {
        return Realm.default
            .objects(ArtistSearchItemObject.self)
            .map { $0.toArtistSearchItem }
   }
}
