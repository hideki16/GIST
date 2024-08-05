//
//  GistListView.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//

import Foundation
import UIKit

protocol GistListViewProtocol {
    var viewModel: GistListViewModelProtocol { get set }
    func updateGists()
}

class GistListView: UIViewController, GistListViewProtocol {
    
    var viewModel: GistListViewModelProtocol
    
    init(viewModel: GistListViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var headerStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var logo: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = .white
        image.image = UIImage(named: "git")
        return image
    }()
    
    var titleLabel: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = .white
        image.image = UIImage(named: "logo")
        return image
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(red: 141/255, green: 148/255, blue: 157/255, alpha: 1.0)
        tableView.register(GistTableViewCell.self, forCellReuseIdentifier: GistTableViewCell.identifier)
        tableView.backgroundColor = UIColor(red: 18/255, green: 16/255, blue: 24/255, alpha: 1)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.fetchGists(completion: {
            result in
            if result {
                self.updateGists()
            } else {
                print("problema")
            }
        })
    }
}

extension GistListView: ViewCodeProtocol {
    func setupView() {
        self.view.backgroundColor = UIColor(red: 18/255, green: 16/255, blue: 24/255, alpha: 1)
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        self.headerStack.addArrangedSubview(logo)
        self.headerStack.addArrangedSubview(titleLabel)
        
        self.view.addSubview(headerStack)
        self.view.addSubview(self.tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.logo.widthAnchor.constraint(equalToConstant: 60),
            self.logo.heightAnchor.constraint(equalTo: logo.widthAnchor, multiplier: 1.0),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 30),
            self.titleLabel.widthAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 5.8),
        ])
        
        NSLayoutConstraint.activate([
            self.headerStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.headerStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.headerStack.bottomAnchor, constant: 10),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

extension GistListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gists.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GistTableViewCell.identifier, for: indexPath) as! GistTableViewCell
        cell.gist = self.viewModel.gists[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = GistDetailView()
        
        GistDetailRouter.createGistDetailModule(GistDetailRef: viewController, gist: self.viewModel.gists[indexPath.row])
        self.navigationController?.pushViewController(viewController , animated: true)
        return
    }
    
    func updateGists() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
