final class DefaultAlbumDetailsViewModel: AlbumDetailsViewModel {
    let albumDetails: AlbumViewModel
    let tracks: [AlbumDetailsTrackCellViewModel]
    let albumStore: AlbumStoreViewModel

    init(from album: Album, imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService) {
        albumDetails = DefaultAlbumViewModel(album: album, imageDownloadService: imageDownloadService)
        tracks = album.tracks.map(DefaultAlbumDetailsTrackCellViewModel.init)
        albumStore = DefaultAlbumStoreViewModel(album: album, albumStoreService: albumStoreService)
    }
}
