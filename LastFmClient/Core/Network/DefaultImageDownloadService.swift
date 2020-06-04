import UIKit
import PromiseKit

class DefaultImageDownloadService: ImageDownloadService {
    enum ImageDownloadError: Error {
        case badUrl
        case downloadError
    }

    func getImage(_ urlString: String) -> Promise<UIImage> {
        return Promise { seal in
            guard let url = URL(string: urlString) else {
                return seal.reject(ImageDownloadError.badUrl)
            }

            if let cachedImage = imageCache.object(forKey: urlString as NSString) {
                return seal.fulfill(cachedImage)
            }

            firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                UIImage(data: $0.data)
            }.done {
                self.imageCache.setObject($0, forKey: urlString as NSString)
                seal.fulfill($0)
            }.catch { _ in
                seal.reject(ImageDownloadError.downloadError)
            }
        }
    }

    fileprivate let imageCache = NSCache<NSString, UIImage>()
}
