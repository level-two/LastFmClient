import Alamofire

protocol LastFmEndpoint: Endpoint {
    var method: String { get }
    var queryParameters: Parameters { get }
}

extension LastFmEndpoint {
    var host: String {
        return "http://ws.audioscrobbler.com"
    }

    var path: String {
        return "/2.0"
    }

    var parameters: Parameters {
        return commonParameters.merging(queryParameters, uniquingKeysWith: { _, new in new })
    }
}

private extension LastFmEndpoint {
    var commonParameters: Parameters {
        return [
            "api_key": apiKey,
            "method": method,
            "format": "json"
        ]
    }

    var apiKey: String {
        return Bundle.main.plistValue(for: .lastFmApiKey)
    }
}
