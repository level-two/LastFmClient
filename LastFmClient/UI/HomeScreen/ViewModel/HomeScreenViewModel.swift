import RxSwift

protocol HomeScreenViewModel: class {
    var onStoredAlbums: Observable<[AlbumCardViewModel]> { get }
    func onCardSelected(at row: Int)
}
