import UIKit
import RealmSwift

class AlbumDetailsModelController {
    fileprivate let networkService: NetworkService
    fileprivate let databaseProvider: DatabaseProvider

    init(networkService: NetworkService, databaseProvider: DatabaseProvider) {
        self.networkService = networkService
        self.databaseProvider = databaseProvider
    }

    func request(albumId: String, completion: @escaping (AlbumDetailsModel?, Error?) -> Void) {

        let albums = databaseProvider.defaultRealm.objects(AlbumDatabaseObject.self)

        if let albumObject = albums.first(where: { $0.albumId == albumId }),
            let imageUrl = albumObject.imageUrl {

            var albumModel = AlbumDetailsModel(from: albumObject)

            networkService.getImage(imageUrl) { result in
                switch result {
                case .success(let image):
                    albumModel.coverImage = image
                    completion(albumModel, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } else {
            networkService.getAlbumDetails(from: .info(albumId: albumId)) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let albumDetails):
                    let albumObject = AlbumDatabaseObject(from: albumDetails)
                    let realm = self.databaseProvider.defaultRealm

                    do {
                        try realm.write { realm.add(albumObject) }
                    } catch {
                        return completion(nil, error)
                    }

                    var albumModel = AlbumDetailsModel(from: albumObject)

                    if let imageUrl = albumObject.imageUrl {
                        self.networkService.getImage(imageUrl) { result in
                            switch result {
                            case .success(let image):
                                albumModel.coverImage = image
                                completion(albumModel, nil)
                            case .failure(let error):
                                completion(nil, error)
                            }
                        }
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}

extension AlbumDatabaseObject {
    convenience init(from albumInfoResponse: AlbumInfoResponse) {
        self.init()

        self.albumId = albumInfoResponse.album.mbid
        self.name = albumInfoResponse.album.name
        self.artist = albumInfoResponse.album.artist
        self.imageUrl = albumInfoResponse.album.image.first { $0.size == "large" }?.url

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MM yyyy, HH:mm"
//        self.releaseDate = dateFormatter.date(from: albumInfoResponse.album.releaseDate)

        let trackObjects = albumInfoResponse.album.tracks.track.map(TrackDatabaseObject.init)
        self.tracks = List<TrackDatabaseObject>()
        self.tracks.append(objectsIn: trackObjects)
    }
}

extension TrackDatabaseObject {
    convenience init(from track: AlbumInfoResponse.Track) {
        self.init()

        self.rank = track.attr.rank
        self.name = track.name
        self.artist = track.artist.name
        self.duration = Int(track.duration) ?? 0
    }
}
