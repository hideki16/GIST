//
//  GistFile.swift
//  Gist
//
//  Created by gabriel hideki on 20/10/22.
//
//
//import Foundation

final class GistFile {
    var filename: String?
    var type: String?
    var language: String?
    var raw_url: String?
    var size: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        filename = try? container.decode(String.self, forKey: .filename)
        type = try? container.decode(String.self, forKey: .type)
        language = try? container.decode(String.self, forKey: .language)
        raw_url = try? container.decode(String.self, forKey: .raw_url)
        size = try? container.decode(Int.self, forKey: .size)
    }
}

extension GistFile: Codable {
    enum CodingKeys: CodingKey {
        case filename
        case type
        case language
        case raw_url
        case size
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filename, forKey: .filename)
        try container.encode(type, forKey: .type)
        try container.encode(language, forKey: .language)
        try container.encode(raw_url, forKey: .raw_url)
        try container.encode(size, forKey: .size)
    }
}

