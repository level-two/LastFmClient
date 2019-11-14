import UIKit
import PromiseKit

protocol NetworkService {
    func getImage(_ urlString: String) -> Promise<UIImage>
    func getAlbumDetails(for albumId: String) -> Promise<AlbumInfoResponse>
}
