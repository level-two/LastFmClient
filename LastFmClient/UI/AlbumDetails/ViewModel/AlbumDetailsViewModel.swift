class AlbumDetailsViewModel {
    var headerViewModel: AlbumDetailsHeaderViewModel?
    var trackViewModel: [AlbumDetailsTrackCellViewModel] = []

    fileprivate let albumId: String
    fileprivate let modelController: AlbumDetailsModelController

    init(albumId: String, networkService: NetworkService, databaseProvider: DatabaseProvider) {
        self.albumId = albumId
        self.modelController = AlbumDetailsModelController(networkService: networkService,
                                                           databaseProvider: databaseProvider)
    }

    func requestData(completion: @escaping (Error?) -> Void) {
        modelController.request(albumId: albumId) { [weak self] albumData, error in
            if let albumData = albumData {
                self?.parse(albumData: albumData)
                completion(nil)
            }
            completion(error)
        }
    }
}

extension AlbumDetailsViewModel {
    fileprivate func parse(albumData: AlbumDetailsModel) {
        headerViewModel = AlbumDetailsHeaderViewModel(from: albumData)
        trackViewModel = albumData.tracks.map { AlbumDetailsTrackCellViewModel(from: $0) }
    }
}
