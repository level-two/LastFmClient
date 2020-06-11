import RealmSwift

@objc enum ImageSizeObject: Int, RealmEnum {
    case small
    case medium
    case large

    init(from imageSize: ImageSize) {
        switch imageSize {
        case .small:
            self = .small
        case .medium:
            self = .medium
        case .large:
            self = .large
        }
    }

    var toImageSize: ImageSize {
        switch self {
        case .small:
            return .small
        case .medium:
            return .medium
        case .large:
            return .large
        }
    }
}
