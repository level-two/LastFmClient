protocol ArtistSearchMatch {
    var mbid: String { get }
    var name: String { get }
    var imageUrl: [ImageSize: String] { get }
}
