import UIKit
import Alamofire
import AlamofireImage
import PromiseKit

extension ImageDownloader: ImageDownloadService {
    enum ImageDownloadError: Error {
        case badUrl
    }

    func getImage(_ urlString: String?) -> Promise<UIImage> {
        return Promise { [weak self] seal in
            guard let urlString = urlString, let url = URL(string: urlString) else {
                return seal.reject(ImageDownloadError.badUrl)
            }

            let request = URLRequest(url: url)

            self?.download(request) { response in
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
