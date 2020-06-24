// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

import UIKit
import PromiseKit
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

final class AlamofireNetworkService: NetworkService {
    init() {
        NetworkActivityIndicatorManager.shared.isEnabled = true

        imageDownloader = ImageDownloader(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            downloadPrioritization: .fifo,
            maximumActiveDownloads: 4,
            imageCache: nil)
    }

    private let imageDownloader: ImageDownloader
}

// MARK: - AlbumFetchService conformance
extension AlamofireNetworkService {
    func albumInfo(mbid: String) -> Promise<Album> {
        return Promise { seal in
            let request = AlbumRequest.info(mbid: mbid)
            AF.request(request).validate().responseDecodable(of: AlbumInfoResponse.self) { response in
                switch response.result {
                case .success(let albumResponse):
                    return seal.fulfill(albumResponse.album.asAlbum)
                case .failure(let error):
                    return seal.reject(error)
                }
            }
        }
    }
}

// MARK: - ArtistSearchService conformance
extension AlamofireNetworkService {
    func search(artist: String) -> Promise<[ArtistSearchItem]> {
        return Promise { seal in
            let request = ArtistRequest.search(artist: artist)

            AF.request(request).validate().responseDecodable(of: ArtistSearchResponse.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    return seal.fulfill(searchResponse.artistSearchItems)
                case .failure(let error):
                    return seal.reject(error)
                }
            }
        }
    }
}

// MARK: - ArtistInfoService conformance
extension AlamofireNetworkService {

    func artistInfo(mbid: String) -> Promise<Artist> {
        return Promise { seal in
            let request = ArtistRequest.getInfo(mbid: mbid)

            AF.request(request).validate().responseDecodable(of: ArtistInfoResponse.self) { response in
                switch response.result {
                case .success(let info):
                    return seal.fulfill(info.asArtist)
                case .failure(let error):
                    return seal.reject(error)
                }
            }
        }
    }

    func topAlbums(mbid: String) -> Promise<[Album]> {
        return Promise { seal in
            let request = ArtistRequest.getTopAlbums(mbid: mbid)

            AF.request(request).validate().responseDecodable(of: ArtistTopAlbumsResponse.self) { response in
                switch response.result {
                case .success(let albums):
                    return seal.fulfill(albums.asArtistTopAlbums)
                case .failure(let error):
                    return seal.reject(error)
                }
            }
        }
    }
}

// MARK: - ImageDownloadService conformance
extension AlamofireNetworkService {
    enum ImageDownloadError: Error {
        case badUrl
    }

    func getImage(_ urlString: String?) -> Promise<UIImage> {
        return Promise { [weak self] seal in
            guard let urlString = urlString, let url = URL(string: urlString) else {
                return seal.reject(ImageDownloadError.badUrl)
            }

            let request = URLRequest(url: url)

            self?.imageDownloader.download(request) { response in
                switch response.result {
                case .success(let image):
                    seal.fulfill(image)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
