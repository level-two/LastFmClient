
enum AlbumCoverSize {
    case small
    case medium
    case large
}

protocol AlbumCardModel {
    var mbid: String { get }
    var coverUrl: [AlbumCoverSize: String] { get }
    var title: String { get }
    var year: String { get }
    var numberOfTracks: Int { get }
}
