import Alamofire

protocol Endpoint: URLRequestConvertible {
    var host: String { get }
    var path: String { get }
    var parameters: Parameters { get }
}

extension Endpoint {
    func asURLRequest() -> URLRequest {
        guard let url = URLBuilder().host(host).path(path).url else {
            fatalError("Failed to create URLRequest")
        }

        return URLRequest(url: url)
    }
}
