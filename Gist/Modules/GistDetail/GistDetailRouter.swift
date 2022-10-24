//
//  GistDetailRouter.swift
//  Gist
//
//  Created by gabriel hideki on 23/10/22.
//

import UIKit

protocol GistDetailRouterProtocol {
    //Presenter -> Wireframe
}

class GistDetailRouter: GistDetailRouterProtocol {
    
    class func createGistDetailModule(GistDetailRef: GistDetailView, gist: Gist) {
       let presenter: GistDetailPresenterProtocol = GistDetailPresenter()
        
        GistDetailRef.gist = gist
        GistDetailRef.presenter = presenter
        GistDetailRef.presenter?.router = GistDetailRouter()
        GistDetailRef.presenter?.view = GistDetailRef
        GistDetailRef.presenter?.interactor = GistDetailInteractor()
        GistDetailRef.presenter?.interactor?.presenter = presenter
    }
    
}
