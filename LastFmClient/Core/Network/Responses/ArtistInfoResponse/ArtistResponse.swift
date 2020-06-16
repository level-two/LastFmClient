import Foundation

struct ArtistResponse: Decodable {
    let name: String
    let mbid: String
    let image: [ImageResponse]
    let bio: ArtistBioResponse
}
