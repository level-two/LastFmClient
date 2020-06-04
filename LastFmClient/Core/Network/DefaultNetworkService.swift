import PromiseKit

class DefaultNetworkService: NetworkService, APIClient {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }
}

extension DefaultNetworkService {
    func getAlbumDetails(for albumId: String) -> Promise<AlbumInfoResponse> {
        let request = AlbumInfoRequest.info(albumId: albumId)
        return fetch(with: request.request)
    }
}
