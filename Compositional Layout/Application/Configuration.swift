//
//  Configuration.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value(_ key: String) -> String {
        return (Bundle.main.infoDictionary?[key] as? String) ?? ""
    }
}
