import PromiseKit

class AlbumDetailsViewModel {
    var headerViewModel: AlbumDetailsHeaderViewModel?
    var footerViewModel: AlbumDetailsFooterViewModel?
    var trackViewModel: [AlbumDetailsTrackCellViewModel] = []

    var onViewModelUpdated: (() -> Void)?

    fileprivate let albumId: String
    fileprivate let modelController: AlbumDetailsModelController

    init(albumId: String, networkService: NetworkService, databaseProvider: DatabaseProvider) {
        self.albumId = albumId
        self.modelController = AlbumDetailsModelController(networkService: networkService,
                                                           databaseProvider: databaseProvider)

        modelController.onAlbumStoredStateChanged(for: albumId) { [weak self] isStored in
            self?.footerViewModel?.isAlbumInCollection = isStored
            self?.onViewModelUpdated?()
        }
    }

    func loadData() -> Promise<Void> {
        return firstly {
            modelController.retrieveModel(for: albumId)
        }.done { [weak self] model in
            self?.updateViewModel(from: model)
            self?.onViewModelUpdated?()
        }
    }

    func storeAlbum() {
        modelController.storeAlbum(with: albumId)
    }

    func removeAlbum() {
        modelController.removeAlbum(with: albumId)
    }
}

extension AlbumDetailsViewModel {
    fileprivate func updateViewModel(from model: AlbumDetailsModel) {
        headerViewModel = AlbumDetailsHeaderViewModel(from: model)
        trackViewModel = model.tracks.map { AlbumDetailsTrackCellViewModel(from: $0) }
        footerViewModel = AlbumDetailsFooterViewModel(from: model)
    }
}
