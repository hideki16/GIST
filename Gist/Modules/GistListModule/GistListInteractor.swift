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
    var worker: GistListWorkerProtocol?
    
    
    func loadGists(completionHandler: @escaping ([Gist]) -> Void) {
        return worker?.loadGists()
    }
}
