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

        let imageUrl = Dictionary(image.compactMap { $0.asImageUrl }, uniquingKeysWith: { _, new in new })

        let album = AlbumImp(mbid: mbid,
                             title: name,
                             artist: artist,
                             imageUrl: imageUrl,
                             tracks: tracks.tracks.map { $0.asTrack })
        return album
    }
}
