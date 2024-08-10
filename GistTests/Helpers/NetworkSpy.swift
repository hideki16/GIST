//
//  NetworkSpy.swift
//  GistTests
//
//  Created by gabriel hideki on 10/08/24.
//

import Foundation
@testable import Gist

final class NetworkSpy: NetworkProtocol {
    var inject: InjectProtocol.Type = Inject.self
    
    var returnedCompletion: Result<Data?, Error> = .success(nil)
    
    private(set) var requestCount: Int = 0
    
    func request(requestEndpoint: RequestEndpoint, completion: @escaping (Result<Data?, Error>) -> Void) {
        requestCount += 1
        completion(returnedCompletion)
    }
}
