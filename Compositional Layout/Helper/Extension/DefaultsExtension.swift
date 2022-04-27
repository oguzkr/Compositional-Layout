//
//  DefaultsExtension.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 25.04.2022.
//

import Foundation

enum DefaultsKeys: String {
    case favorites = "kFavorites"
}

class Defaults: UserDefaults {
    class func get<T>(_ key: DefaultsKeys) -> T? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    class func set<T>(_ key: DefaultsKeys, value: T) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    class func remove(_ key: DefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
