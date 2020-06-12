import Foundation

class URLBuilder {
    var url: URL? {
        return components.url
    }

    func fragment(_ fragment: String?) -> URLBuilder {
        components.fragment = fragment
        return self
    }

    func host(_ host: String?) -> URLBuilder {
        components.host = host
        return self
    }

    func password(_ password: String?) -> URLBuilder {
        components.password = password
        return self
    }

    func path(_ path: String) -> URLBuilder {
        components.path = path
        return self
    }

    func port(_ port: Int?) -> URLBuilder {
        components.port = port
        return self
    }

    func query(_ query: String?) -> URLBuilder {
        components.query = query
        return self
    }

    func queryItems(_ queryItems: [URLQueryItem]?) -> URLBuilder {
        components.queryItems = queryItems
        return self
    }

    func scheme(_ scheme: String?) -> URLBuilder {
        components.scheme = scheme
        return self
    }

    func user(_ user: String?) -> URLBuilder {
        components.user = user
        return self
    }

    private var components = URLComponents()
}
