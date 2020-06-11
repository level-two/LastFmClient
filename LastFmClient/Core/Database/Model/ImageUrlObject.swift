import RealmSwift

class ImageUrlObject: Object {
    @objc dynamic var size: ImageSizeObject = .small
    @objc dynamic var url: String = ""

    required init() {
        super.init()
    }

    init(size: ImageSize, url: String) {
        super.init()
        self.size = ImageSizeObject(from: size)
        self.url = url
    }

    var toImageUrl: (ImageSize, String) {
        return (size.toImageSize, url)
    }
}
