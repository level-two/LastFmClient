import UIKit
import RealmSwift
import PromiseKit

class AlbumDetailsModelController {
    fileprivate let networkService: NetworkService
    fileprivate let databaseProvider: DatabaseProvider
    fileprivate var notificationToken: NotificationToken?

    init(networkService: NetworkService, databaseProvider: DatabaseProvider) {
        self.networkService = networkService
        self.databaseProvider = databaseProvider
    }

    deinit {
        notificationToken?.invalidate()
    }

    func onAlbumStoredStateChanged(for albumId: String, callback: @escaping (Bool) -> Void) {
        notificationToken?.invalidate()
        notificationToken = databaseProvider.onAlbumUpdate(albumId: albumId) { [weak self] in
            guard let isStored = self?.databaseProvider.isAlbumStored(albumId: albumId) else { return }
            callback(isStored)
        }
    }

    func retrieveModel(for albumId: String) -> Promise<AlbumDetailsModel> {
        var model: AlbumDetailsModel?

        return firstly {
            self.getAlbum(for: albumId)
        }.then { album -> Promise<UIImage> in
            model = AlbumDetailsModel(from: album)
            return self.getImage(with: album.imageUrl)
        }.compactMap { image -> AlbumDetailsModel? in
            model?.coverImage = image
            return model
        }
    }

    func storeAlbum(with albumId: String) {
        databaseProvider.setAlbumStored(albumId: albumId, stored: true)
    }

    func removeAlbum(with albumId: String) {
        databaseProvider.setAlbumStored(albumId: albumId, stored: false)
    }
}

fileprivate extension AlbumDetailsModelController {
    func getAlbum(for albumId: String) -> Promise<AlbumDatabaseObject> {
        if let album = databaseProvider.getAlbum(with: albumId) {
            return .init { $0.fulfill(album) }
        }

        return networkService.getAlbumDetails(for: albumId).map { [weak self] response in
            let album = AlbumDatabaseObject(from: response)
            self?.databaseProvider.storeAlbum(album)
            return album
        }
    }

    func getImage(with url: String) -> Promise<UIImage> {
        return networkService.getImage(url)
    }
}

fileprivate extension AlbumDatabaseObject {
    convenience init(from albumInfoResponse: AlbumInfoResponse) {
        self.init()

        self.albumId = albumInfoResponse.album.mbid
        self.name = albumInfoResponse.album.name
        self.artist = albumInfoResponse.album.artist
        self.imageUrl = albumInfoResponse.album.image.first { $0.size == "large" }?.url ?? ""

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MM yyyy, HH:mm"
//        self.releaseDate = dateFormatter.date(from: albumInfoResponse.album.releaseDate)

        let trackObjects = albumInfoResponse.album.tracks.track.map(TrackDatabaseObject.init)
        self.tracks = List<TrackDatabaseObject>()
        self.tracks.append(objectsIn: trackObjects)
    }
}

fileprivate extension TrackDatabaseObject {
    convenience init(from track: AlbumInfoResponse.Track) {
        self.init()

        self.rank = track.attr.rank
        self.name = track.name
        self.artist = track.artist.name
        self.duration = Int(track.duration) ?? 0
    }
}
