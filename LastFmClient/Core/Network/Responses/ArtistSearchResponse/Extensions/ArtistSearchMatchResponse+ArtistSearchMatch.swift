extension ArtistSearchMatchResponse: ArtistSearchMatch {
    var artist: String {
        return self.name
    }
}
