//
//  GistError.swift
//  Gist
//
//  Created by gabriel hideki on 07/08/24.
//

import Foundation

enum GistsError: Error, Equatable {
    case notFound
    case notAlowed
    case parse
}

