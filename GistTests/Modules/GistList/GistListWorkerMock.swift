//
//  MockGistList.swift
//  GistTests
//
//  Created by gabriel hideki on 11/08/24.
//

@testable import Gist

class GistListWorkerMock: GistListWorkerProtocol {
    var result: Result<[Gist], Error>?
    var fetchCount: Int = 0
    
    func fetchGists(page: Int, completion: @escaping (Result<[Gist], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
        
        fetchCount += 1
    }
}
