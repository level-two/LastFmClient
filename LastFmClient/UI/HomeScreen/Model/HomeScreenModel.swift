import UIKit
import RealmSwift
import PromiseKit

class HomeScreenModel {
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

//    func onAlbumStoredStateChanged(for albumId: String, callback: @escaping (Bool) -> Void) {
//        notificationToken?.invalidate()
//        notificationToken = databaseProvider.onAlbumStateUpdate(albumId: albumId) { [weak self] in
//            guard let isStored = self?.databaseProvider.isAlbumStored(albumId: albumId) else { return }
//            callback(isStored)
//        }
//    }

    func removeAlbum(with albumId: String) {
//        databaseProvider.setAlbumStored(albumId: albumId, stored: false)
    }
}
//
//fileprivate extension HomeScreenModel {
//    func getAlbum(for albumId: String) -> Promise<AlbumDatabaseObject> {
//        if let album = databaseProvider.getAlbum(with: albumId) {
//            return .init { $0.fulfill(album) }
//        }
//
//        return networkService.getAlbumDetails(for: albumId).map { [weak self] response in
//            let album = AlbumDatabaseObject(from: response)
//            self?.databaseProvider.storeAlbum(album)
//            return album
//        }
//    }
//
//    func getImage(with url: String) -> Promise<UIImage> {
//        return networkService.getImage(url)
//    }
//}
