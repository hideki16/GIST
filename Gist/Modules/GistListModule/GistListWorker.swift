//
//  GistListWorker.swift
//  Gist
//
//  Created by gabriel hideki on 03/08/24.
//

import Foundation

protocol GistListWorkerProtocol {
    func fetchGists(completion: @escaping (Result<[Gist], Error>) -> Void)
}

class GistListWorker: GistListWorkerProtocol {
    
    private let network: GistListNetworkProtocol
    
    init(network: GistListNetworkProtocol = GistListNetwork()) {
        self.network = network
    }
    
    func fetchGists(completion: @escaping (Result<[Gist], Error>) -> Void) {
        network.fetchGists(completionHandler: {
            result in
            completion(.success(result))
        })
    }
}
