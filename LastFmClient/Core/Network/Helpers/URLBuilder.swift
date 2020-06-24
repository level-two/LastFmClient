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
