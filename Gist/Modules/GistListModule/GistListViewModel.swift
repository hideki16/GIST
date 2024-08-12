//
//  GistListViewModel.swift
//  Gist
//
//  Created by gabriel hideki on 05/08/24.
//

import Foundation

protocol GistListViewModelProtocol {
    var worker: GistListWorkerProtocol { get }
    var gists: [Gist] { get }
    var currentPage: Int { get }
    
    func fetchGists(completion: @escaping (Bool) -> Void)
}

class GistListViewModel: GistListViewModelProtocol {
    
    internal var worker: GistListWorkerProtocol
    var gists: [Gist] = []
    private(set) var currentPage: Int = 0
    
    init(worker: GistListWorkerProtocol) {
        self.worker = worker
    }
    
    func fetchGists(completion: @escaping (Bool) -> Void) {
        worker.fetchGists(page: currentPage) {
            result in
            switch result {
            case .success(let gists):
                self.gists.append(contentsOf: gists)
                self.currentPage += 1
                completion(true)
            case .failure(let error):
                print("Failed to load gists: \(error)")
                completion(false)
            }
        }
    }
}
