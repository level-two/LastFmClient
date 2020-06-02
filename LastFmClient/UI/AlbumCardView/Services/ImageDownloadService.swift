import UIKit

protocol ImageDownloadService {
    func getImage(url: String, callback: @escaping (UIImage?) -> Void)
}
