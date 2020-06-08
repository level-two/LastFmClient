import Foundation

class URLBuilder {
    var url: URL? {
        return components.url
    }

    func fragment(_ fragment: String?) -> Self {
        components.fragment = fragment
        return self
    }

    func host(_ host: String?) -> Self {
        components.host = host
        return self
    }

    func password(_ password: String?) -> Self {
        components.password = password
        return self
    }

    func path(_ path: String) -> Self {
        components.path = path
        return self
    }

    func port(_ port: Int?) -> Self {
        components.port = port
        return self
    }

    func query(_ query: String?) -> Self {
        components.query = query
        return self
    }

    func queryItems(_ queryItems: [URLQueryItem]?) -> Self {
        components.queryItems = queryItems
        return self
    }

    func scheme(_ scheme: String?) -> Self {
        components.scheme = scheme
        return self
    }

    func user(_ user: String?) -> Self {
        components.user = user
        return self
    }

    private var components = URLComponents()
}
