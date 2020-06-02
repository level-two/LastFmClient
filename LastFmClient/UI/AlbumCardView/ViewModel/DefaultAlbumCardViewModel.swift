import UIKit

class DefaultAlbumCardViewModel: AlbumCardViewModel {
    let cover: UIImage?
    let title: String
    let year: String
    let tracksNumber: Int
    let inCollection: Bool



    
}

extension DefaultAlbumCardViewModel {

    static var mock: AlbumCardViewModel {
        return DefaultAlbumCardViewModel(
            cover: UIImage(named: "Golova"),
            title: "Golova",
            year: "2013",
            tracksNumber: 13,
            inCollection: true)
    }

}
