import PromiseKit
import Alamofire

protocol ArtistSearchService {
    func search(artist: String) -> Promise<[ArtistSearchItem]>
}
