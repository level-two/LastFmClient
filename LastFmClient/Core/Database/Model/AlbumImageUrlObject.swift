import RealmSwift

class AlbumImageUrlObject: Object {
    @objc dynamic var size: AlbumImageSize = .small
    @objc dynamic var url: String = ""

    required init() {
        super.init()
    }

    init(size: ImageSize, url: String) {
        super.init()
        self.size = AlbumImageSize(from: size)
        self.url = url
    }
}
