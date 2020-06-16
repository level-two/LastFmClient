extension ArtistBioResponse {

    var asArtistBio: ArtistBio {
        struct ArtistBioImp: ArtistBio {
            let summary: String
            let content: String
        }

        return ArtistBioImp(summary: summary, content: content)
    }

}
