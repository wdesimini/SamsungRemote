//
//  WebSocketEvent+Extension.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation
import Starscream

extension WebSocketEvent {
    var body: Data? {
        if case let .text(string) = self {
            return string.data(using: .utf8)
        } else if case let .binary(data) = self {
            return data
        }
        return nil
    }
}
