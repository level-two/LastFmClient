import RxSwift

protocol HomeScreenViewModel: class {
    var albumCells: Observable<[AlbumCardViewModel]> { get }

    func onCardSelected(at row: Int)
}
