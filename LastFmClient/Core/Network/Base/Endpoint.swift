import Foundation

protocol Endpoint {
    var host: String { get }
    var path: String { get }
    var apiKey: String { get }
    var queryParameters: [String: String] { get }
}

extension Endpoint {
    var request: URLRequest {
        guard let url = urlComponents.url else {
            fatalError("Failed to create URLRequest")
        }

        return URLRequest(url: url)
    }

    fileprivate var urlComponents: URLComponents {
        guard var components = URLComponents(string: host) else {
            fatalError("Failed to create URLComponents")
        }

        components.path = path

        var parameters = queryParameters
        parameters["api_key"] = apiKey
        components.setQueryItems(with: parameters)

        return components
    }
}
