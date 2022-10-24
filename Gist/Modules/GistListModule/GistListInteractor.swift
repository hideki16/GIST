//
//  GistListInteractor.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//

import Foundation
import UIKit

protocol GistListInteractorProtocol {
    var presenter: GistListPresenterProtocol? {get set}
    
    func loadGists(completionHandler: @escaping ([Gist]) -> Void)
}

class GistListInteractor: GistListInteractorProtocol {
    
    var presenter: GistListPresenterProtocol?
    
    
    func loadGists(completionHandler: @escaping ([Gist]) -> Void) {
        guard let url = URL(string: "https://api.github.com/gists/public?page=0") else {return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {return }
            print(data)
            do {
                let response = try JSONDecoder().decode([Gist].self, from: data)
                completionHandler(response)
            } catch {
                print(error)
                return
            }
            
            print(response ?? "")
        }
        task.resume()
    }
}
