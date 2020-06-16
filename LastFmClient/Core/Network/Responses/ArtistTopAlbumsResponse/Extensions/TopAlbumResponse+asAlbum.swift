extension TopAlbumResponse {

    var asAlbum: Album? {
        struct AlbumImp: Album {
            let mbid: String
            let title: String
            let artist: String
            let imageUrl: [ImageSize: String]
            let tracks: [Track]
        }

        guard let mbid = mbid else { return nil }

        let imageUrl = Dictionary(image.compactMap { $0.asImageUrl }, uniquingKeysWith: { _, new in new })

        let album = AlbumImp(mbid: mbid,
                             title: title,
                             artist: artistInfo.name,
                             imageUrl: imageUrl,
                             tracks: [])
        return album
    }

}
