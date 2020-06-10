import Foundation

class AlbumCardHashableWrapper {
    let wrappedCard: AlbumCardViewModel

    init(wrappedCard: AlbumCardViewModel) {
        self.wrappedCard = wrappedCard
    }

    private let id = UUID()
}

extension AlbumCardHashableWrapper: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: AlbumCardHashableWrapper, rhs: AlbumCardHashableWrapper) -> Bool {
        lhs.id == rhs.id
    }
}
