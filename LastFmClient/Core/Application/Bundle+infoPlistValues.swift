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

extension Bundle {
    enum InfoPlistKey: String {
        case versionNumber = "CFBundleShortVersionString"
        case buildNumber = "CFBundleVersion"
        case databaseSchemaVersion = "DatabaseSchemaVersion"
        case lastFmApiKey = "LastFmApiKey"
    }

    func plistValue<T>(for key: InfoPlistKey) -> T {
        guard let val = object(forInfoDictionaryKey: key.rawValue) as? T else {
            fatalError("Failed get \(type(of: T.self)) value for \(key.rawValue) key from info.plist")
        }
        return val
    }
}
