//
//  GistTableViewCell.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//

//FontAwesome6Free-Regular", "FontAwesome6Free-Solid

import UIKit

protocol GistTableViewCellProtocol {
    func configureCell(gist: Gist)
}

class GistTableViewCell: UITableViewCell, GistTableViewCellProtocol {
    
    static let identifier = "GistTableViewCell"
    
    var contentStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fillProportionally
        stack.spacing = DesignSystem.Spacing.xl
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var headerStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = DesignSystem.Spacing.s
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
        label.text = ""
        label.textColor = DesignSystem.Colors.titleTextColor
        label.font = DesignSystem.Fonts.bodyFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeStamp: UILabel = {
        var label = UILabel()
        label.text = "Criado agora"
        label.numberOfLines = 0
        label.textColor = DesignSystem.Colors.textColor
        label.font = DesignSystem.Fonts.captionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filesStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = DesignSystem.Spacing.xs
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var fileIcon: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = DesignSystem.Colors.textColor
        image.image = UIImage(named: "code-square")
        return image
    }()
    
    var files: UILabel = {
        var label = UILabel()
        label.text = "-"
        label.textColor = DesignSystem.Colors.textColor
        label.font = DesignSystem.Fonts.bodyFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var commentsIcon: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.tintColor = DesignSystem.Colors.textColor
        image.image = UIImage(named: "comment")
        return image
    }()
    
    var comments: UILabel = {
        var label = UILabel()
        label.text = "-"
        label.textColor = DesignSystem.Colors.textColor
        label.font = DesignSystem.Fonts.bodyFont
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
    
    func configureCell(gist: Gist) {
        name.text = gist.owner?.name ?? ""
        avatar.downloaded(from: gist.owner?.avatarImage ?? "")
        
        let components = gist.creationDate?.timeSince(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        if let month = components?.month, month != 0 {timeStamp.text = "Criado há \(month) mês/es"}
        if let day = components?.day, day != 0 {timeStamp.text = "Criado há \(day) dia/s"}
        if let min = components?.minute, min != 0 {timeStamp.text = "Criado há \(min) minuto/s"}
        if let sec = components?.second, sec != 0 {timeStamp.text = "Criado há \(sec) segundo/s"}
        
        if let fileList =  gist.files?.count {files.text = String(fileList)}
        if let commentList = gist.comments {comments.text = String(commentList)}
    }
}

extension GistTableViewCell {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = DesignSystem.Colors.backgroundColor
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
            self.contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: DesignSystem.Spacing.s),
            self.contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.Spacing.s),
            self.contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.Spacing.m),
            self.contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.Spacing.m)
        ])
        
        NSLayoutConstraint.activate([
            self.headerStack.widthAnchor.constraint(equalTo: contentStack.widthAnchor),
            self.headerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.Spacing.s),
            self.headerStack.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.Spacing.s)
        ])
        
        NSLayoutConstraint.activate([
            self.filesStack.leadingAnchor.constraint(equalTo: detailsStack.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.avatar.widthAnchor.constraint(equalToConstant: DesignSystem.Spacing.xxl),
            self.avatar.heightAnchor.constraint(equalToConstant: DesignSystem.Spacing.xxl),
            self.fileIcon.widthAnchor.constraint(equalToConstant: DesignSystem.Spacing.m),
            self.fileIcon.heightAnchor.constraint(equalToConstant: DesignSystem.Spacing.m),
            self.commentsIcon.widthAnchor.constraint(equalToConstant: DesignSystem.Spacing.m),
            self.commentsIcon.heightAnchor.constraint(equalToConstant: DesignSystem.Spacing.m),
        ])
        
        NSLayoutConstraint.activate([
            self.name.heightAnchor.constraint(equalToConstant: DesignSystem.Spacing.l),
            self.timeStamp.heightAnchor.constraint(equalToConstant: DesignSystem.Spacing.xl),
            self.files.heightAnchor.constraint(equalToConstant: DesignSystem.Spacing.l),
            self.files.widthAnchor.constraint(equalToConstant: DesignSystem.Spacing.xl),
            self.comments.heightAnchor.constraint(equalToConstant: DesignSystem.Spacing.l),
            self.comments.widthAnchor.constraint(equalToConstant: DesignSystem.Spacing.xl),
        ])

        self.layoutIfNeeded()
    }
}
