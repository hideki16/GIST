//
//  GistDetailNetwork.swift
//  Gist
//
//  Created by gabriel hideki on 05/08/24.
//

import Foundation

protocol GistDetailNetworkProtocol {
    func fetchGist(gistid: String, completionHandler: @escaping (Gist) -> Void)
}

class GistDetailNetwork: GistDetailNetworkProtocol {
    func fetchGist(gistid: String, completionHandler: @escaping (Gist) -> Void) {
        guard let url = URL(string: "https://api.github.com/gists/\(gistid)") else {return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {return }
            print(data)
            do {
                let response = try JSONDecoder().decode(Gist.self, from: data)
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
