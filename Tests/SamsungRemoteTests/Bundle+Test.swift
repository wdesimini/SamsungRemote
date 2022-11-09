//
//  Bundle+Test.swift
//
//
//  Created by Wilson Desimini on 11/3/22.
//

import Foundation

extension Bundle {
    enum Error: Swift.Error {
        case invalidData
        case invalidPath
    }

    func data(_ file: String) throws -> Data {
        guard let path = path(
            forResource: file, ofType: "json"
        ) else {
            throw Error.invalidPath
        }
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url)
    }

    func string(_ file: String) throws -> String {
        guard let str = String(
            data: try data(file), encoding: .utf8
        ) else {
            throw Error.invalidData
        }
        return str
    }
}
