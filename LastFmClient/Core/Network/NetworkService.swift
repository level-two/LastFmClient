import UIKit

protocol NetworkService {
    func getImage(_ urlString: String, completion: @escaping (Result<UIImage>) -> Void)
    func getAlbumDetails(from request: AlbumInfoRequest, completion: @escaping (Result<AlbumInfoResponse>) -> Void)
}
