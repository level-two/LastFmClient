import UIKit
import PromiseKit

protocol ImageDownloadService {
    func getImage(url: String) -> Promise<UIImage>
}
