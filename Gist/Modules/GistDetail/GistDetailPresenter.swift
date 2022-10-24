//
//  GistDetailPresenter.swift
//  Gist
//
//  Created by gabriel hideki on 23/10/22.
//

import Foundation

protocol GistDetailPresenterProtocol {
    var interactor: GistDetailInteractorProtocol? {get set}
    var view: GistDetailViewProtocol? {get set}
    var router: GistDetailRouterProtocol? {get set}
    func viewDidLoad()
}

class GistDetailPresenter: GistDetailPresenterProtocol {
    
    var view: GistDetailViewProtocol?
    var interactor: GistDetailInteractorProtocol?
    var router: GistDetailRouterProtocol?

    var gists: [Gist] = []
    
    func viewDidLoad() {
        interactor?.loadGist(gistid: view?.gist?.id ?? "", completionHandler: {gist in
            self.view?.updateGist(gist: gist)
        })
    }
}
