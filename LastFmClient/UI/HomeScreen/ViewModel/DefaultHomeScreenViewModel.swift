class DefaultHomeScreenViewModel {
//    var albumsViewModel: [HomeScreenAlbumViewModel] = .init(repeating: .mock, count: 10)
//    var onViewModelUpdated: (() -> Void)?

    let imageDownloadService: ImageDownloadService
    let albumStoreService: AlbumStoreService

    init(imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService) {
        self.imageDownloadService = imageDownloadService
        self.albumStoreService = albumStoreService
    }

//    init(networkService: NetworkService, databaseProvider: DatabaseProvider) {
////        self.modelController = HomeScreenModelController(networkService: networkService,
////                                                         databaseProvider: databaseProvider)
////
////        modelController.onStoredAlbumsUpdate { [weak self] storedAlbums in
////            self?.albumsViewModel = storedAlbums.map(HomeScreenAlbumViewModel.init)
////            self?.onViewModelUpdated?()
////        }
//
////        _ = modelController.retrieveModel(for: albumId).done { [weak self] model in
////            self?.updateViewModel(from: model)
////            self?.onViewModelUpdated?()
////        }
//    }
//
////    func loadData() -> Promise<Void> {
////        return firstly {
////            modelController.retrieveModel(for: albumId)
////            }.done { [weak self] model in
////                self?.updateViewModel(from: model)
////                self?.onViewModelUpdated?()
////        }
////    }
//
//    func removeAlbum(at index: Int) {
////        let albumId = albumsViewModel[index].albumId
////        modelController.removeAlbum(with: albumId)
//        albumsViewModel.remove(at: index)
//        onViewModelUpdated?()
//    }
}
