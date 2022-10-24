//
//  GistListPresenter.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//

import Foundation
import UIKit

protocol GistListPresenterProtocol {
    var interactor: GistListInteractorProtocol? {get set}
    var view: GistListViewProtocol? {get set}
    var router: GistListRouterProtocol? {get set}
    func viewDidLoad()
}

class GistListPresenter: GistListPresenterProtocol {
    
    var view: GistListViewProtocol?
    var interactor: GistListInteractorProtocol?
    var router: GistListRouterProtocol?

    var gists: [Gist] = []
    
    func viewDidLoad() {
        interactor?.loadGists(completionHandler: {gists in
            self.view?.updateGists(gists: gists)
        })
    }
}
