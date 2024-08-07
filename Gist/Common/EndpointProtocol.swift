//
//  EndpointProtocol.swift
//  Gist
//
//  Created by gabriel hideki on 06/08/24.
//

import Foundation

protocol RequestEndpoint {
    var path: String { get }
    var queryItems: [String: Any] { get }
    var method: HTTPMethod { get }
}

enum HTTPMethod: String {
    case GET = "GET"
}
