import Foundation

final class AlbumCardHashableWrapper: Hashable {
    let wrappedCard: AlbumCardViewModel

    init(wrappedCard: AlbumCardViewModel) {
        self.wrappedCard = wrappedCard
    }
}

extension AlbumCardHashableWrapper {
    func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedCard.album.mbid)
    }

    static func == (lhs: AlbumCardHashableWrapper, rhs: AlbumCardHashableWrapper) -> Bool {
        lhs.wrappedCard.album.mbid == rhs.wrappedCard.album.mbid
    }
}
