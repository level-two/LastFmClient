import UIKit
import PromiseKit

protocol ImageDownloadService {
    func getImage(_ urlString: String?) -> Promise<UIImage>
}
