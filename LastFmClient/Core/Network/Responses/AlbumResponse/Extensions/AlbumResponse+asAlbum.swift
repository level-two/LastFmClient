import Foundation

extension AlbumResponse {
    var asAlbum: Album {
        struct AlbumImp: Album {
            let mbid: String
            let title: String
            let artist: String
            let imageUrl: [ImageSize: String]
            let tracks: [Track]
        }

        let imageUrl = Dictionary(albumInfo.image.compactMap { $0.asImageUrl }, uniquingKeysWith: { _, new in new })

        let album = AlbumImp(mbid: albumInfo.mbid,
                             title: albumInfo.name,
                             artist: albumInfo.artist,
                             imageUrl: imageUrl,
                             tracks: albumInfo.tracks.tracks.map { $0.asTrack })
        return album
    }
}
