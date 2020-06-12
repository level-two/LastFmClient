import Alamofire

protocol Endpoint: URLRequestConvertible {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: Parameters { get }
}

extension Endpoint {
    func asURLRequest() -> URLRequest {

        let builtUrl = URLBuilder()
            .scheme(scheme)
            .host(host)
            .path(path)
            .queryItems(parameters.map { URLQueryItem(name: $0, value: String(describing: $1)) })
            .url

        guard let url = builtUrl else {
            fatalError("Failed to create URLRequest")
        }

        return URLRequest(url: url)
    }
}
