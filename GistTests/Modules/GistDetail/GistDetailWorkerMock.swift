//
//  GistDetailWorkerMock.swift
//  GistTests
//
//  Created by gabriel hideki on 11/08/24.
//

@testable import Gist

class GistDetailWorkerMock: GistDetailWorkerProtocol {
    var result: Result<Gist, Error>?
    var fetchCount: Int = 0
    
    func fetchGist(gistId: String, completion: @escaping (Result<Gist, any Error>) -> Void) {
        if let result = result {
            completion(result)
        }
        
        fetchCount += 1
    }
}
