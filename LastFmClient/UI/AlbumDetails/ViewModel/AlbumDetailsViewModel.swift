import RxSwift

protocol AlbumDetailsViewModel {
    var albumDetails: AlbumViewModel { get }
    var tracks: [AlbumDetailsTrackCellViewModel] { get }
    var albumStore: AlbumStoreViewModel { get }
}
