//
//  GistListRouter.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//

import UIKit

protocol GistListRouterProtocol {
    //Presenter -> Wireframe
    func pushToGistDetail(with gist: Gist,from view: UIViewController)
    static func createGistListModule(GistListRef: GistListView)
}

class GistListRouter: GistListRouterProtocol {
   
    func pushToGistDetail(with Gist: Gist,from view: UIViewController) {
    }
    
    class func createGistListModule(GistListRef: GistListView) {
       let presenter: GistListPresenterProtocol = GistListPresenter()
        
        GistListRef.presenter = presenter
        GistListRef.presenter?.router = GistListRouter()
        GistListRef.presenter?.view = GistListRef
        GistListRef.presenter?.interactor = GistListInteractor()
        GistListRef.presenter?.interactor?.presenter = presenter
    }
    
}
