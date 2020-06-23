import PromiseKit
import Alamofire

protocol AlbumInfoService {
    func albumInfo(mbid: String) -> Promise<Album>
}
