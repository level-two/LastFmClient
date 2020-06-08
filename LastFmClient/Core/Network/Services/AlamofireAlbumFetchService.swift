import PromiseKit
import Alamofire

class AlamofireAlbumFetchService {

    func fetchAlbum(with mbid: String) -> Promise<Album> {
        return Promise { seal in
            let request = AlbumRequest.info(mbid: mbid)

            AF.request(request)
                .validate()
                .responseDecodable(of: AlbumResponse.self) { response in
                    switch response.result {
                    case .success(let album):
                        return seal.fulfill(album)
                    case .failure(let error):
                        return seal.reject(error)
                    }
                }
        }
    }

}
