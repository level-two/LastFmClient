import UIKit
import PromiseKit

protocol NetworkService {
    func getAlbumDetails(for albumId: String) -> Promise<AlbumInfoResponse>
}
