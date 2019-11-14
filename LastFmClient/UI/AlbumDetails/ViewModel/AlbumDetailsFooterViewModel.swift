import Foundation

struct AlbumDetailsFooterViewModel {
    var isAlbumInCollection: Bool = false

    init(from model: AlbumDetailsModel) {
        isAlbumInCollection = model.isStored
    }
}
