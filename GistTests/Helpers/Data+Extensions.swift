//
//  Data+Extensions.swift
//  GistTests
//
//  Created by gabriel hideki on 10/08/24.
//

import Foundation

extension Data {
    static func makeData(value: Any) -> Data? {
        if let dictionary = value as? [String: Any] {
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                return data
            } catch {
                return nil
            }
        } else if let array = value as? [[String: Any]] {
            do {
                let data = try JSONSerialization.data(withJSONObject: array, options: [])
                return data
            } catch {
                return nil
            }
        }
        return nil
    }
}
