//
//  GistListWorker.swift
//  Gist
//
//  Created by gabriel hideki on 03/08/24.
//

import Foundation

protocol GistListWorkerProtocol {
    func fetchGists(page: Int, completion: @escaping (Result<[Gist], Error>) -> Void)
}

class GistListWorker: GistListWorkerProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network(inject: Inject.self)) {
        self.network = network
    }
    
    func fetchGists(page: Int, completion: @escaping (Result<[Gist], Error>) -> Void) {
        let endpoint: RequestEndpoint = GistListRequestEndpoint.getList(page)
        
        network.request(requestEndpoint: endpoint) { result in
            switch result {
            case .success(let data):
                guard let data = data, let response = try? JSONDecoder().decode([Gist].self, from: data) else {return }
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
