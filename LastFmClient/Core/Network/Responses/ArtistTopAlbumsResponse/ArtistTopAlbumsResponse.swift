import Foundation

struct ArtistTopAlbumsResponse: Decodable {
    let albums: [TopAlbumResponse]

    private enum RootKey: String, CodingKey {
        case topAlbums = "topalbums"
    }

    private enum AlbumsKey: String, CodingKey {
        case albums = "album"
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKey.self)
        let albumsContainer = try rootContainer.nestedContainer(keyedBy: AlbumsKey.self, forKey: .topAlbums)
        albums = try albumsContainer.decode([TopAlbumResponse].self, forKey: .albums)
    }
}
