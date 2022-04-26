//
//  Endpoint.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import Foundation

enum Endpoint {
    
    case users, album, photos
    
    func baseURL() -> String {
        switch self {
        case .users:
            return "\(Configuration.value("api_webservice_url"))/users"
        case .album:
            return "\(Configuration.value("api_webservice_url"))/albums"
        case .photos:
            return "\(Configuration.value("api_webservice_url"))/photos"
        }
    }
    
}
