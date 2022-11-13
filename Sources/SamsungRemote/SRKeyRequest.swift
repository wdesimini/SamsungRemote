//
//  SRKeyRequest.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

public struct SRKeyRequest: SRRequest {
    public struct ResponseBody: Codable {
        public let clients: [SRDevice]
        public let id: String
    }

    public let command: SRRemoteControlCommand
    public let config: SRConfig

    init(
        app: String,
        command: SRRemoteControlCommand,
        ipAddress: String,
        token: SRToken
    ) {
        self.command = command
        config = .secure(app: app, ipAddress: ipAddress, token: token)
    }

    public var body: String? {
        try? command.asString()
    }
}
