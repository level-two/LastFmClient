import UIKit
import PromiseKit
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class AlamofireNetworkService: NetworkService {
    init() {
        NetworkActivityIndicatorManager.shared.isEnabled = true

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

// MARK: - ArtistSearchService conformance
extension AlamofireNetworkService {
    func search(artist: String) -> Promise<[ArtistSearchItem]> {
        return Promise { seal in
            let request = ArtistRequest.search(artist: artist)

            AF.request(request).validate().responseDecodable(of: ArtistSearchResponse.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    return seal.fulfill(searchResponse.matches)
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
