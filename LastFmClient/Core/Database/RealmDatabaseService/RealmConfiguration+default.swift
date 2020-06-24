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

import RealmSwift

extension Realm.Configuration {
    static func `default`() -> Realm.Configuration {
        var configuration = Realm.Configuration()
        configuration.schemaVersion = UInt64(Bundle.main.plistValue(for: .databaseSchemaVersion) ?? 0)
        configuration.fileURL = configuration.fileURL?.replacingLastPathComponent("default.realm")
        return configuration
    }
}
