import RxSwift
import RxRelay

final class DefaultHomeScreenViewModel: HomeScreenViewModel {
    var onStoredAlbums: Observable<[AlbumCardViewModel]> {
        return storedAlbums.asObservable()
    }

    init(imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService) {
        self.imageDownloadService = imageDownloadService
        self.albumStoreService = albumStoreService

        setupBindings()
        //makeMock()
    }

    func onCardSelected(at row: Int) {

    }

    private let storedAlbums = BehaviorRelay<[AlbumCardViewModel]>(value: [])
    private let imageDownloadService: ImageDownloadService
    private let albumStoreService: AlbumStoreService
    private let disposeBag = DisposeBag()

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

private extension DefaultHomeScreenViewModel {
    func setupBindings() {
        let imageDownloadService = self.imageDownloadService
        let albumStoreService = self.albumStoreService

        albumStoreService.storedAlbums().map { albums in
            albums.map {
                DefaultAlbumCardViewModel(
                    album: $0,
                    imageDownloadService: imageDownloadService,
                    albumStoreService: albumStoreService)
            }
        }
        .bind(to: storedAlbums)
        .disposed(by: disposeBag)
    }

    func makeMock() {
        DispatchQueue.global(qos: .background).async {
            stride(from: 0, to: 100, by: 1).forEach { [weak self] idx in
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

                let mockAlbum = MockAlbum(
                    mbid: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0-\(idx)",
                    title: "Album Title \(idx)",
                    artist: "Supa Artist",
                    imageUrl: [.medium: "https://habrastorage.org/webt/mr/u7/wu/mru7wusyxtgjbaptshr3o5olipu.png"],
                    mockTracks: [])

                self?.albumStoreService.storeAlbum(mockAlbum)
            }
        }
    }
}
