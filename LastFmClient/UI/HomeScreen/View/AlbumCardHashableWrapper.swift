import Foundation

final class AlbumCardHashableWrapper: Hashable {
    let wrappedCard: AlbumCardViewModel

    init(wrappedCard: AlbumCardViewModel) {
        self.wrappedCard = wrappedCard
    }
}

extension AlbumCardHashableWrapper {
    func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedCard.mbid)
    }

    static func == (lhs: AlbumCardHashableWrapper, rhs: AlbumCardHashableWrapper) -> Bool {
        lhs.wrappedCard.mbid == rhs.wrappedCard.mbid
    }
}
