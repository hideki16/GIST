//
//  GistTableViewCell.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//

//FontAwesome6Free-Regular", "FontAwesome6Free-Solid

import UIKit

class GistTableViewCell: UITableViewCell {
    static let identifier = "GistTableViewCell"
    
    var gist: Gist? {
        didSet {
            name.text = gist?.owner?.name ?? ""
            avatar.downloaded(from: gist?.owner?.avatarImage ?? "")
            
            let components = gist?.creationDate?.timeSince(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
            if let month = components?.month, month != 0 {timeStamp.text = "Criado há \(month) mês/es"}
            if let day = components?.day, day != 0 {timeStamp.text = "Criado há \(day) dia/s"}
            if let min = components?.minute, min != 0 {timeStamp.text = "Criado há \(min) minuto/s"}
            if let sec = components?.second, sec != 0 {timeStamp.text = "Criado há \(sec) segundo/s"}
            
            if let fileList =  gist?.files?.count {files.text = String(fileList)}
            if let commentList = gist?.comments {comments.text = String(commentList)}
        }
    }
    
    var contentStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fillProportionally
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var headerStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var avatar: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20.0
        return image
    }()
    
    var detailsStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var name: UILabel = {
        var label = UILabel()
        label.text = "user"
        label.textColor = UIColor(red: 107/255, green: 164/255, blue: 248/255, alpha: 1.0)
        label.font = UIFont(name: "Helvetica", size: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeStamp: UILabel = {
        var label = UILabel()
        label.text = "Criado agora"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 141/255, green: 148/255, blue: 157/255, alpha: 1.0)
        label.font = UIFont(name: "Helvetica", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filesStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var fileIcon: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = UIColor(red: 141/255, green: 148/255, blue: 157/255, alpha: 1.0)
        image.image = UIImage(named: "code-square")
        return image
    }()
    
    var files: UILabel = {
        var label = UILabel()
        label.text = "-"
        label.textColor = UIColor(red: 141/255, green: 148/255, blue: 157/255, alpha: 1.0)
        label.font = UIFont(name: "Helvetica", size: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var commentsIcon: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = UIColor(red: 141/255, green: 148/255, blue: 157/255, alpha: 1.0)
        image.image = UIImage(named: "comment")
        return image
    }()
    
    var comments: UILabel = {
        var label = UILabel()
        label.text = "-"
        label.textColor = UIColor(red: 141/255, green: 148/255, blue: 157/255, alpha: 1.0)
        label.font = UIFont(name: "Helvetica", size: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GistTableViewCell {
    func setupView() {
        self.backgroundColor = .clear
        self.setupSubviews()
        self.setupConstraints()
    }
    
    func setupSubviews() {
        headerStack.addArrangedSubview(avatar)
        filesStack.addArrangedSubview(fileIcon)
        filesStack.addArrangedSubview(files)
        
        filesStack.addArrangedSubview(commentsIcon)
        filesStack.addArrangedSubview(comments)
        
        detailsStack.addArrangedSubview(name)
        detailsStack.addArrangedSubview(timeStamp)
        detailsStack.addArrangedSubview(filesStack)
        
        headerStack.addArrangedSubview(detailsStack)
        contentStack.addArrangedSubview(headerStack)
        
        addSubview(contentStack)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            self.contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            self.contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            self.headerStack.widthAnchor.constraint(equalTo: contentStack.widthAnchor),
            self.headerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.headerStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            self.filesStack.leadingAnchor.constraint(equalTo: detailsStack.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.avatar.widthAnchor.constraint(equalToConstant: 40),
            self.avatar.heightAnchor.constraint(equalToConstant: 40),
            self.fileIcon.widthAnchor.constraint(equalToConstant: 15),
            self.fileIcon.heightAnchor.constraint(equalToConstant: 15),
            self.commentsIcon.widthAnchor.constraint(equalToConstant: 15),
            self.commentsIcon.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        NSLayoutConstraint.activate([
            self.name.heightAnchor.constraint(equalToConstant: 20),
            self.timeStamp.heightAnchor.constraint(equalToConstant: 30),
            self.files.heightAnchor.constraint(equalToConstant: 20),
            self.files.widthAnchor.constraint(equalToConstant: 30),
            self.comments.heightAnchor.constraint(equalToConstant: 20),
            self.comments.widthAnchor.constraint(equalToConstant: 30),
        ])

        self.layoutIfNeeded()
    }
}
