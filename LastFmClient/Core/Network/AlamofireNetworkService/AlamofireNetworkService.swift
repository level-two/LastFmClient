import UIKit
import PromiseKit
import Alamofire
import AlamofireImage

class AlamofireNetworkService: NetworkService {
    init() {
        imageDownloader = ImageDownloader(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            downloadPrioritization: .fifo,
            maximumActiveDownloads: 4,
            imageCache: nil)
    }

    private let imageDownloader: ImageDownloader
}

// MARK: - AlbumFetchService conformance
extension AlamofireNetworkService {
    func fetchAlbum(with mbid: String) -> Promise<Album> {
        return Promise { seal in
            let request = AlbumRequest.info(mbid: mbid)

            AF.request(request).validate().responseDecodable(of: AlbumResponse.self) { response in
                switch response.result {
                case .success(let album):
                    return seal.fulfill(album)
                case .failure(let error):
                    return seal.reject(error)
                }
            }
        }
    }
}

// MARK: - ImageDownloadService conformance
extension AlamofireNetworkService {
    enum ImageDownloadError: Error {
        case badUrl
    }

    func getImage(_ urlString: String?) -> Promise<UIImage> {
        return Promise { [weak self] seal in
            guard let urlString = urlString, let url = URL(string: urlString) else {
                return seal.reject(ImageDownloadError.badUrl)
            }

            let request = URLRequest(url: url)

            self?.imageDownloader.download(request) { response in
                switch response.result {
                case .success(let image):
                    seal.fulfill(image)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
