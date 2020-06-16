extension ArtistTopAlbumsResponse {

    var asArtistTopAlbums: [Album] {
        return albums.compactMap { $0.asAlbum }
    }

}
