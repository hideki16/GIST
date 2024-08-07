//
//  GistFile.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//
//
//import Foundation

struct GistFile: Codable {
    var filename: String?
    var type: String?
    var language: String?
    var rawUrl: String?
    var size: Int?

    enum CodingKeys: String, CodingKey {
        case filename
        case type
        case language
        case rawUrl = "raw_url"
        case size
    }
}

