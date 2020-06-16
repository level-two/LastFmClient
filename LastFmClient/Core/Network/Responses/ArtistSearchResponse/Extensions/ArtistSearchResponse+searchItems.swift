extension ArtistSearchResponse {

    var artistSearchItems: [ArtistSearchItem] {
        return matches.map { $0.asArtistSearchItem }
    }

}
