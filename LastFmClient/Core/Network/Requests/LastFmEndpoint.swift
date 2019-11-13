import Foundation

protocol LastFmEndpoint: Endpoint {
    var method: String { get }
    var parameters: [String: String] { get }
}

extension LastFmEndpoint {
    var host: String {
        return "http://ws.audioscrobbler.com"
    }

    var path: String {
        return "/2.0"
    }

    var apiKey: String {
        guard let apiKey = Bundle.main.lastFmApiKey else { fatalError("API Key is not defined") }
        return apiKey
    }

    var queryParameters: [String: String] {
        var params = parameters
        params["method"] = method
        params["format"] = "json"
        return params
    }
}
