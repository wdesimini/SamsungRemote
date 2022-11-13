//
//  SRAppRequest.swift
//
//
//  Created by Wilson Desimini on 11/13/22.
//

import Foundation

public struct SRAppRequest: SRRequest {
    public struct ResponseBody: Codable {
    }

    public let command: SRChannelEmitCommand
    public let config: SRConfig

    init(
        app: String,
        command: SRChannelEmitCommand,
        ipAddress: String,
        token: SRToken
    ) {
        self.command = command
        config = .secure(
            app: app,
            ipAddress: ipAddress,
            token: token
        )
    }

    public var body: String? {
        try? command.asString()
    }
}
