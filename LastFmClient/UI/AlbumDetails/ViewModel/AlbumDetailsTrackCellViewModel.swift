import Foundation

struct AlbumDetailsTrackCellViewModel {
    var title: String
    var duration: String
}

//extension TimeInterval {
//    var formatted: String? {
//        let formatter = DateComponentsFormatter()
//        formatter.zeroFormattingBehavior = .pad
//        formatter.allowedUnits = [.minute, .second]
//
//        if self >= 3600 {
//            formatter.allowedUnits.insert(.hour)
//        }
//
//        return formatter.string(from: self)
//    }
//}
