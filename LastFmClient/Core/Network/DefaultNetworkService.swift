import Foundation
import UIKit

class DefaultNetworkService: NetworkService, APIClient {
    let session: URLSession
    fileprivate let imageCache = NSCache<NSString, UIImage>()

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }
}

extension DefaultNetworkService {
    func getAlbumDetails(from request: AlbumInfoRequest, completion: @escaping (Result<AlbumInfoResponse>) -> Void) {
        fetch(with: request.request, completion: completion)
    }
}

extension DefaultNetworkService {
    enum ImageDownloadError: Error {
        case badUrl
        case downloadError
        case incorrectData
    }

    func getImage(_ urlString: String, completion: @escaping (Result<UIImage>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(ImageDownloadError.badUrl))
        }

        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            return completion(.success(cachedImage))
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard error == nil else {
                return completion(.failure(ImageDownloadError.downloadError))
            }

            guard let data = data, let image = UIImage(data: data) else {
                return completion(.failure(ImageDownloadError.incorrectData))
            }

            self?.imageCache.setObject(image, forKey: urlString as NSString)
            completion(.success(image))

        }).resume()
    }
}
