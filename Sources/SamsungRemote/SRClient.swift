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

    private func execute<Request: SRRequest>(
        _ request: Request
    ) async throws -> Request.Response? {
        let websocket = websocketFactory.websocket(from: request)
        guard let data = try await websocket
            .connectUntilBody(write: request.body) else { return nil }
        return try parser.response(from: data)
    }

    public func auth() async throws -> SRToken? {
        let request = SRAuthRequest(app: app, ipAddress: ipAddress)
        let response = try await execute(request)
        return response?.data?.token
    }

    public func key(_ key: SRRemoteKey) async throws -> SRKeyRequest
        .ResponseBody? {
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
        let response = try await execute(request)
        return response?.data
    }
}
