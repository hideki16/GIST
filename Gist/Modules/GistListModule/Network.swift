//
//  GistListNetworkManager.swift
//  Gist
//
//  Created by gabriel hideki on 03/08/24.
//

import Foundation

protocol NetworkProtocol {
    var inject: InjectProtocol.Type { get }
    
    func request(requestEndpoint: RequestEndpoint, completion: @escaping (Result<Data?, Error>) -> Void)
}

class Network: NetworkProtocol {
    
    var inject: InjectProtocol.Type
    
    init(inject: InjectProtocol.Type) {
        self.inject = inject
    }
    
    func request(requestEndpoint: RequestEndpoint, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard var url = URL(string: inject.baseUrl + requestEndpoint.path) else {
            return
        }
        
        url = self.makeQuery(url: url,items: requestEndpoint.queryItems)
        
        var request = URLRequest(url: url)
        request.httpMethod = requestEndpoint.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {return }
            
            completion(.success(data))
            
        }
        task.resume()
    }
    
    private func makeQuery(url: URL, items: [String: Any]) -> URL {
        guard var urlComponents: URLComponents = .init(url: url, resolvingAgainstBaseURL: false) else {return url}
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        items.forEach { value in
            guard let item = value.value as? String else {return }
            queryItems.append(.init(name: value.key, value: item))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url ?? url
    }
}
