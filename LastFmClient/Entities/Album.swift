protocol Album {
    var mbid: String { get }
    var title: String { get }
    var artist: String { get }
    var imageUrl: [ImageSize: String] { get }
    var tracks: [Track] { get }
}
