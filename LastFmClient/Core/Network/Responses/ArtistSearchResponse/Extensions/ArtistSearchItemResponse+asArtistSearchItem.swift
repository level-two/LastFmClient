extension ArtistSearchItemResponse {

    var asArtistSearchItem: ArtistSearchItem {
        struct ArtistSearchItemImp: ArtistSearchItem {
            let mbid: String
            let artist: String
        }

        return ArtistSearchItemImp(mbid: mbid, artist: artist)
    }

}
