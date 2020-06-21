struct DefaultAlbumCardViewModel: AlbumCardViewModel {
    let album: Album
    let albumViewModel: AlbumViewModel
    let storeViewModel: AlbumStoreViewModel

    init(album: Album, imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService) {
        self.album = album
        albumViewModel = DefaultAlbumViewModel(album: album, imageDownloadService: imageDownloadService)
        storeViewModel = DefaultAlbumStoreViewModel(album: album, albumStoreService: albumStoreService)
    }
}
