//
//  GistDetailView.swift
//  Gist
//
//  Created by gabriel hideki on 23/10/22.
//


import Foundation
import UIKit

protocol GistDetailViewProtocol {
    var gist: Gist? {get set}
    func updateGist(gist: Gist?)
}

class GistDetailView: UIViewController, GistDetailViewProtocol {
    
    var contentStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var avatarImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = .white
        image.layer.cornerRadius = 150
        return image
    }()
    
    var name: UILabel = {
        var label = UILabel()
        label.text = "user"
        label.textColor = UIColor(red: 197/255, green: 198/255, blue: 216/255, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 25)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "user"
        label.textColor = UIColor(red: 197/255, green: 198/255, blue: 216/255, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var presenter: GistDetailPresenterProtocol?
    var gist: Gist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setupView()
    }
    
    func updateGist(gist: Gist?) {
        self.gist = gist
        DispatchQueue.main.async {
            self.avatarImage.downloaded(from: gist?.owner?.avatarImage ?? "")
            self.name.text = gist?.owner?.name ?? "-"
            self.descriptionLabel.text = gist?.description ?? ""
        }
    }
}

extension GistDetailView: ViewCodeProtocol {
    
    func setupView() {
        self.view.backgroundColor = UIColor(red: 18/255, green: 16/255, blue: 24/255, alpha: 1)
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10),
            self.contentStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            self.contentStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            self.avatarImage.widthAnchor.constraint(equalToConstant: 300),
            self.avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor, multiplier: 1.0),
            self.name.heightAnchor.constraint(equalToConstant: 30),
            self.name.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            self.descriptionLabel.heightAnchor.constraint(equalToConstant: 90),
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
        ])
        
    }
    
    func setupSubviews() {
        self.view.addSubview(contentStack)
        
        contentStack.addArrangedSubview(avatarImage)
        contentStack.addArrangedSubview(name)
        contentStack.addArrangedSubview(descriptionLabel)
    }
}
