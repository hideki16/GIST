//
//  GistDetailViewModel.swift
//  Gist
//
//  Created by gabriel hideki on 05/08/24.
//

import Foundation

protocol GistDetailViewModelProtocol {
    var worker: GistDetailWorkerProtocol {get set}
    var gist: Gist? {get set}
    
    func fetchGistDetail(completion: @escaping (Bool) -> Void)
}

class GistDetailViewModel: GistDetailViewModelProtocol {
    
    internal var worker: GistDetailWorkerProtocol
    var gist: Gist?
    
    init(worker: GistDetailWorkerProtocol, gist: Gist) {
        self.worker = worker
        self.gist = gist
    }
    
    func fetchGistDetail(completion: @escaping (Bool) -> Void) {
        guard let gist = self.gist, let id = gist.id else {
            completion(false)
            return
        }
        
        worker.fetchGist(gistId: id, completion: {
            result in
            switch result {
            case .success(let gist):
                self.gist = gist
                completion(true)
            case .failure(let error):
                print("Failed to load gists: \(error)")
                completion(false)
            }
        })
    }
}
