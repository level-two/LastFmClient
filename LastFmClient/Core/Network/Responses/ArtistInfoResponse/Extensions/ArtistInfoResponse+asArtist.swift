extension ArtistInfoResponse {

    var asArtist: Artist {
        struct ArtistImp: Artist {
            let mbid: String
            let name: String
            let imageUrl: [ImageSize: String]
            let bio: ArtistBio
        }

        let imageUrl = Dictionary(artist.image.compactMap { $0.asImageUrl }, uniquingKeysWith: { _, new in new })

        return ArtistImp(mbid: artist.mbid,
                         name: artist.name,
                         imageUrl: imageUrl,
                         bio: artist.bio.asArtistBio)
    }

}
