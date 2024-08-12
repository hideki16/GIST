//
//  GistDetailView.swift
//  Gist
//
//  Created by gabriel hideki on 23/10/22.
//


import Foundation
import UIKit

protocol GistDetailViewProtocol {
    var viewModel: GistDetailViewModelProtocol { get set }
    func updateGist()
}

class GistDetailView: UIViewController, GistDetailViewProtocol {
    
    var viewModel: GistDetailViewModelProtocol
    
    var contentStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = DesignSystem.Spacing.s
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var avatarImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = DesignSystem.Colors.textColor
        image.layer.cornerRadius = 150
        return image
    }()
    
    var name: UILabel = {
        var label = UILabel()
        label.text = ""
        label.textColor = DesignSystem.Colors.titleTextColor
        label.font = DesignSystem.Fonts.titleFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.textColor = DesignSystem.Colors.textColor
        label.font = DesignSystem.Fonts.subtitleFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: GistDetailViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        viewModel.fetchGistDetail(completion: {
            result in
            if result {
                self.updateGist()
            } else {
                print("houve um problema")
            }
        })
    }
    
    func updateGist() {
        DispatchQueue.main.async {
            self.avatarImage.downloaded(from: self.viewModel.gist?.owner?.avatarImage ?? "")
            self.name.text = self.viewModel.gist?.owner?.name ?? "-"
            self.descriptionLabel.text = self.viewModel.gist?.description ?? ""
        }
    }
}

extension GistDetailView: ViewCodeProtocol {
    
    func setupView() {
        self.view.backgroundColor = DesignSystem.Colors.backgroundColor
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: DesignSystem.Spacing.s),
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
