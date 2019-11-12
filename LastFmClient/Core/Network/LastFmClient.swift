import Foundation

class LastFmClient: APIClient {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getAlbumDetails(from request: AlbumInfoRequest, completion: @escaping (Result<AlbumInfoResponse>) -> Void) {
        fetch(with: request.request, completion: completion)
    }
}
