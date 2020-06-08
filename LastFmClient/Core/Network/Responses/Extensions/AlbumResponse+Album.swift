import Foundation

extension AlbumResponse: Album {
    var mbid: String {
        return albumInfo.mbid
    }

    var title: String {
        return albumInfo.name
    }

    var artist: String {
        return albumInfo.artist
    }

    var imageUrl: [ImageSize: String] {
        var imageUrl = [ImageSize: String]()
        albumInfo.image.compactMap { $0.imageUrl }.forEach {
            imageUrl[$0.size] = $0.url
        }
        return imageUrl
    }

    var tracks: [Track] {
        return albumInfo.tracks.track
    }
}
