//
//  Inject.swift
//  Gist
//
//  Created by gabriel hideki on 06/08/24.
//

import Foundation

protocol InjectProtocol {
    static var baseUrl: String { get }
}

struct Inject: InjectProtocol {
    static var baseUrl = "https://api.github.com"
}
