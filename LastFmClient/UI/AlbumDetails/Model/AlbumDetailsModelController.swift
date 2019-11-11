import UIKit

class AlbumDetailsModelController {
    fileprivate let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func request(albumId: String, completion: @escaping (AlbumDetailsModel?, Error?) -> Void) {
        networkService.album.getInfo(albumId: albumId) { [weak self] albumInfo in
            // FIXME: Handle errors
            var model = AlbumDetailsModel(from: albumInfo)

            self?.networkService.getImage(albumInfo.mediumImageUrl) { image in
                model.coverImage = image
                completion(model, nil)
            }
        }
    }
}
