import PromiseKit
import Alamofire

protocol AlbumFetchService {
    func fetchAlbum(with mbid: String) -> Promise<Album>
}
