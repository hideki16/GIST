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
        stack.spacing = DesignSystem.Spacing.xs
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var logo: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = DesignSystem.Colors.tertiaryColor
        image.image = UIImage(named: "git")
        return image
    }()
    
    var titleLabel: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = DesignSystem.Colors.tertiaryColor
        image.image = UIImage(named: "logo")
        return image
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = DesignSystem.Colors.textColor
        tableView.register(GistTableViewCell.self, forCellReuseIdentifier: GistTableViewCell.identifier)
        tableView.backgroundColor = DesignSystem.Colors.backgroundColor
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
        self.view.backgroundColor = DesignSystem.Colors.backgroundColor
        
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
            self.headerStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: DesignSystem.Spacing.s),
        ])
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.headerStack.bottomAnchor, constant: DesignSystem.Spacing.s),
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GistTableViewCell.identifier, for: indexPath) as? GistTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(gist: self.viewModel.gists[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = GistDetailView(viewModel: GistDetailViewModel(worker: GistDetailWorker(), gist: viewModel.gists[indexPath.row]))
        
        self.navigationController?.pushViewController(viewController , animated: true)
        return
    }
    
    func updateGists() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
