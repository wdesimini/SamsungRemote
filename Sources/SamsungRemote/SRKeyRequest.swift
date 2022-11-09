//
//  SRKeyRequest.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

public struct SRKeyRequest: SRRequest {
    public let command: SRCommand
    public let config: SRConfig

    init(app: String, command: SRCommand, ipAddress: String, token: SRToken) {
        self.command = command
        config = .secure(app: app, ipAddress: ipAddress, token: token)
    }

    public var body: String? {
        try? command.asString()
    }
}
