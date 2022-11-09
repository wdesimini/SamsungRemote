//
//  WebSocketEvent+Test.swift
//
//
//  Created by Wilson Desimini on 11/3/22.
//

import Foundation
import Starscream

extension WebSocketEvent {
    static var connectedMock: Self {
        .connected([
            "Upgrade": "WebSocket",
            "Connection": "Upgrade",
            "Sec-WebSocket-Accept": "EGAWtyUO7abrLqn03RRsj5mADls=",
        ])
    }

    static func textMock(_ file: String) throws -> Self {
        .text(try Bundle.module.string(file))
    }
}
