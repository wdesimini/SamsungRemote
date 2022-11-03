//
//  Serialization+Extension.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

extension Data {
    var asJSON: [String: AnyObject]? {
        try? JSONSerialization.jsonObject(with: self) as? [String: AnyObject]
    }

    var asString: String? {
        String(data: self, encoding: .utf8)
    }
}

extension Dictionary {
    var asData: Data? {
        try? JSONSerialization.data(withJSONObject: self)
    }

    var asString: String? {
        asData?.asString
    }
}

extension Encodable {
    func asString(
        encoder: JSONEncoder = .init()
    ) throws -> String? {
        try encoder.encode(self).asString
    }
}

extension String {
    var asBase64: String? {
        asData?.base64EncodedString()
    }

    var asData: Data? {
        data(using: .utf8)
    }

    var asJSON: [String: AnyObject]? {
        asData.flatMap(\.asJSON)
    }
}
