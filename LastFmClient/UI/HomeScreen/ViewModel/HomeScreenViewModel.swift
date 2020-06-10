import RxSwift

protocol HomeScreenViewModel: class {
    init(imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService)

    var albumCells: Observable<[AlbumCardViewModel]> { get }

    func onCardSelected(at row: Int)
}
