//
//  GistListNetworkManager.swift
//  Gist
//
//  Created by gabriel hideki on 03/08/24.
//

import Foundation

protocol GistListNetworkProtocol {
    func fetchGists(completionHandler: @escaping ([Gist]) -> Void)
}

class GistListNetworkManager: GistListNetworkProtocol {
    
    
    func fetchGists(completionHandler: @escaping ([Gist]) -> Void) {
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
