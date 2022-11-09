//
//  SRClient.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation
import Starscream

@available(macOS 10.15, *) public class SRClient {
    public let app: String
    public let ipAddress: String
    public let token: SRToken?
    public let websocketFactory: SRWebSocketFactoryProtocol
    private let parser = SRResponseParser()

    public init(
        app: String,
        ipAddress: String,
        token: SRToken? = nil,
        websocketFactory: SRWebSocketFactoryProtocol
    ) {
        self.app = app
        self.ipAddress = ipAddress
        self.token = token
        self.websocketFactory = websocketFactory
    }

    private func execute(_ request: SRRequest) async throws -> Data? {
        let websocket = websocketFactory.websocket(from: request)
        return try await websocket.connectUntilBody(write: request.body)
    }

    public func auth() async throws -> SRToken? {
        let request = SRAuthRequest(app: app, ipAddress: ipAddress)
        guard let data = try await execute(request) else { return nil }
        let body: SRAuthResponseBody = try parser.responseBody(from: data)
        return body.token
    }

    public func key(_ key: SRRemoteKey) async throws -> SRKeyResponseBody? {
        guard let token = token else { throw SRError.missingToken }
        let params = SRCommand.Params(
            cmd: "Click",
            dataOfCmd: key,
            option: false,
            typeOfRemote: .remoteKey
        )
        let command = SRCommand(method: "ms.remote.control", params: params)
        let request = SRKeyRequest(
            app: app,
            command: command,
            ipAddress: ipAddress,
            token: token
        )
        guard let data = try await execute(request) else { return nil }
        return try parser.responseBody(from: data)
    }
}
