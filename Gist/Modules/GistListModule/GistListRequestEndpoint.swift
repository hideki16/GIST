//
//  GistListRequestEndpoint.swift
//  Gist
//
//  Created by gabriel hideki on 06/08/24.
//

import Foundation

enum GistListRequestEndpoint: RequestEndpoint {
    case getList(Int)
    case getDetail(String)
    
    var path: String {
        switch self {
        case .getList:
            return "/gists/public"
        case let .getDetail(id):
            return "/gists/\(id)"
        }
    }
    
    var queryItems: [String : Any] {
        switch self {
        case let .getList(page):
            return ["page": "\(page)"]
        case .getDetail:
            return [:]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getList:
            return .GET
        case .getDetail:
            return .GET
        }
    }
}
