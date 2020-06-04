protocol AlbumDetailsService {
    func getAlbumDetails(mbid: String, callback: @escaping (AlbumCardModel) -> Void)
}
