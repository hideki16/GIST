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
        case .getDetail:
            return "/gists"
        }
    }
    
    var queryItems: [String : Any] {
        switch self {
        case let .getList(page):
            return ["page": "\(page)"]
        case let .getDetail(id):
            return [id: ""]
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
