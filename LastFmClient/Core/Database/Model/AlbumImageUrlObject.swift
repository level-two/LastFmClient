import RealmSwift

class AlbumImageUrlObject: Object {
    dynamic var imageSize: ImageSize = .small
    dynamic var imageUrl: String = ""

    required init() {
        super.init()
    }

    init(imageSize: ImageSize, imageUrl: String) {
        super.init()
        self.imageSize = imageSize
        self.imageUrl = imageUrl
    }
}
