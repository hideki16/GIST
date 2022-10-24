//
//  Gist.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//

import Foundation
import UIKit

final class Gist {
    var id: String?
    var owner: Owner?
    var description: String?
    var files: [String: GistFile?]?
    var creationDate: String?
    var lastUpdatedDate: String?
    var comments: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(String.self, forKey: .id)
        owner = try? container.decode(Owner.self, forKey: .owner)
        description = try? container.decode(String.self, forKey: .description)
        files = try container.decode([String: GistFile].self, forKey: .files)
        creationDate = try? container.decode(String.self, forKey: .creationDate)
        lastUpdatedDate = try? container.decode(String.self, forKey: .lastUpdatedDate)
        comments = try? container.decode(Int.self, forKey: .comments)
    }
}

extension Gist: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case description
        case files
        case creationDate = "created_at"
        case lastUpdatedDate = "updated_at"
        case comments
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(owner, forKey: .owner)
        try? container.encode(description, forKey: .description)
        try? container.encode(files, forKey: .files)
        try? container.encode(creationDate, forKey: .creationDate)
        try? container.encode(lastUpdatedDate, forKey: .lastUpdatedDate)
        try? container.encode(comments, forKey: .comments)
        
    }
}

final class Owner {
    var name: String?
    var avatarImage: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
        avatarImage = try? container.decode(String.self, forKey: .avatarImage)
    }
}

extension Owner: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarImage = "avatar_url"
        case files
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(name, forKey: .name)
        try? container.encode(avatarImage, forKey: .avatarImage)
    }
}
//"owner": {
//    "login": "monalisa",
//    "id": 104456405,
//    "node_id": "U_kgDOBhHyLQ",
//    "avatar_url": "https://avatars.githubusercontent.com/u/104456405?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/monalisa",
//    "html_url": "https://github.com/monalisa",
//    "followers_url": "https://api.github.com/users/monalisa/followers",
//    "following_url": "https://api.github.com/users/monalisa/following{/other_user}",
//    "gists_url": "https://api.github.com/users/monalisa/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/monalisa/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/monalisa/subscriptions",
//    "organizations_url": "https://api.github.com/users/monalisa/orgs",
//    "repos_url": "https://api.github.com/users/monalisa/repos",
//    "events_url": "https://api.github.com/users/monalisa/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/monalisa/received_events",
//    "type": "User",
//    "site_admin": true
//  }
