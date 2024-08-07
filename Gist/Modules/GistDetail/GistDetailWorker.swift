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

    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network(inject: Inject.self)) {
        self.network = network
    }
    
    func fetchGist(gistId: String, completion: @escaping (Result<Gist, any Error>) -> Void) {
        let endpoint: RequestEndpoint = GistListRequestEndpoint.getDetail(gistId)
        
        network.request(requestEndpoint: endpoint) { result in
            switch result {
            case .success(let data):
                guard let data = data, let response = try? JSONDecoder().decode(Gist.self, from: data) else {return }
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
