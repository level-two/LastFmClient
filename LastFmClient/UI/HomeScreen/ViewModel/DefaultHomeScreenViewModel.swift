import RxSwift
import RxRelay

struct MockAlbum: Album {
    let mbid: String
    let title: String
    let artist: String
    let imageUrl: [ImageSize: String]
    let mockTracks: [MockTrack]

    var tracks: [Track] {
        return mockTracks
    }
}

struct MockTrack: Track {
    var rank: Int
    var name: String
    var artist: String
    var duration: Int
}

class DefaultHomeScreenViewModel: HomeScreenViewModel {
//    var albumsViewModel: [HomeScreenAlbumViewModel] = .init(repeating: .mock, count: 10)
//    var onViewModelUpdated: (() -> Void)?

    let imageDownloadService: ImageDownloadService
    let albumStoreService: AlbumStoreService

    init(imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService) {
        self.imageDownloadService = imageDownloadService
        self.albumStoreService = albumStoreService

        let mockAlbum = MockAlbum(
            mbid: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0",
            title: "Album Title",
            artist: "Supa Artist",
            imageUrl: [.medium: "https://habrastorage.org/webt/mr/u7/wu/mru7wusyxtgjbaptshr3o5olipu.png"],
            mockTracks: [])

        albumCellsVar.accept([
            DefaultAlbumCardViewModel(
                album: mockAlbum,
                imageDownloadService: imageDownloadService,
                albumStoreService: albumStoreService)
        ])
    }

    var albumCells: Observable<[AlbumCardViewModel]> {
        return albumCellsVar.asObservable()
    }

    private let albumCellsVar = BehaviorRelay<[AlbumCardViewModel]>(value: [])

    func onCardSelected(at row: Int) {

    }

//    init(networkService: NetworkService, databaseProvider: DatabaseProvider) {
//        self.modelController = HomeScreenModelController(networkService: networkService,
//                                                         databaseProvider: databaseProvider)
//
//        modelController.onStoredAlbumsUpdate { [weak self] storedAlbums in
//            self?.albumsViewModel = storedAlbums.map(HomeScreenAlbumViewModel.init)
//            self?.onViewModelUpdated?()
//        }

//        _ = modelController.retrieveModel(for: albumId).done { [weak self] model in
//            self?.updateViewModel(from: model)
//            self?.onViewModelUpdated?()
//        }
//    }

//    func loadData() -> Promise<Void> {
//        return firstly {
//            modelController.retrieveModel(for: albumId)
//            }.done { [weak self] model in
//                self?.updateViewModel(from: model)
//                self?.onViewModelUpdated?()
//        }
//    }

//    func removeAlbum(at index: Int) {
//        let albumId = albumsViewModel[index].albumId
//        modelController.removeAlbum(with: albumId)
//        albumsViewModel.remove(at: index)
//        onViewModelUpdated?()
//    }
}
