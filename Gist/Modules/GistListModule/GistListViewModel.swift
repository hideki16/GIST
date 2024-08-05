//
//  GistListViewModel.swift
//  Gist
//
//  Created by gabriel hideki on 05/08/24.
//

import Foundation

protocol GistListViewModelProtocol {
    var worker: GistListWorkerProtocol {get set}
    var gists: [Gist] {get set}
    
    func fetchGists(completion: @escaping (Bool) -> Void)
}

class GistListViewModel: GistListViewModelProtocol {
    
    internal var worker: GistListWorkerProtocol
    var gists: [Gist] = []
    
    init(worker: GistListWorkerProtocol) {
        self.worker = worker
    }
    
    func fetchGists(completion: @escaping (Bool) -> Void) {
        worker.fetchGists(completion: {
            result in
            switch result {
            case .success(let gists):
                self.gists = gists
                completion(true)
            case .failure(let error):
                print("Failed to load gists: \(error)")
                completion(false)
            }
        })
    }
}
