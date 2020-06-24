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

import Alamofire

protocol LastFmEndpoint: Endpoint {
    var method: String { get }
    var queryParameters: Parameters { get }
}

extension LastFmEndpoint {
    var scheme: String {
        return "http"
    }

    var host: String {
        return "ws.audioscrobbler.com"
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
