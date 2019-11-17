import PromiseKit

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest) -> Promise<T>
}

extension APIClient {
    func fetch<T: Decodable>(with request: URLRequest) -> Promise<T> {
        return firstly {
            URLSession.shared.dataTask(.promise, with: request)
        }.compactMap {
            try JSONDecoder().decode(T.self, from: $0.data)
        }
    }
}
