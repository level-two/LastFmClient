import PromiseKit
import Alamofire

protocol ArtistInfoService {
    func getInfo(mbid: String) -> Promise<Artist>
    func getTopAlbums(mbid: String) -> Promise<[Album]>
}
