import PromiseKit
import Alamofire

protocol ArtistInfoService {
    func artistInfo(mbid: String) -> Promise<Artist>
    func topAlbums(mbid: String) -> Promise<[Album]>
}
