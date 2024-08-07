//
//  Gist.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//

import Foundation
import UIKit


struct Gist: Codable {
    var id: String?
    var owner: Owner?
    var description: String?
    var files: [String: GistFile?]?
    var creationDate: String?
    var lastUpdatedDate: String?
    var comments: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case description
        case files
        case creationDate = "created_at"
        case lastUpdatedDate = "updated_at"
        case comments
    }
}

struct Owner: Codable {
    var name: String?
    var avatarImage: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarImage = "avatar_url"
    }
}
