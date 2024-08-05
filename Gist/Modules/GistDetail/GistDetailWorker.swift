//
//  GistDetailWorker.swift
//  Gist
//
//  Created by gabriel hideki on 05/08/24.
//

import Foundation

protocol GistDetailWorkerProtocol {
    func fetchGist(gistId: String, completion: @escaping (Result<Gist, Error>) -> Void)
}

class GistDetailWorker: GistDetailWorkerProtocol {

    private let network: GistDetailNetworkProtocol
    
    init(network: GistDetailNetworkProtocol = GistDetailNetwork()) {
        self.network = network
    }
    
    func fetchGist(gistId: String, completion: @escaping (Result<Gist, any Error>) -> Void) {
        network.fetchGist(gistid: gistId, completionHandler: {
            result in
            completion(.success(result))
        })
    }
}
