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
    public let websocketFactory: SRWebSocketFactoryProtocol
    private let parser = SRResponseParser()

    public init(
        app: String,
        ipAddress: String,
        websocketFactory: SRWebSocketFactoryProtocol
    ) {
        self.app = app
        self.ipAddress = ipAddress
        self.websocketFactory = websocketFactory
    }

    public func auth() async throws -> SRToken? {
        let request = SRAuthRequest(app: app, ipAddress: ipAddress)
        let websocket = websocketFactory.websocket(from: request)
        guard let data = try await websocket.connectUntilBody()
        else { return nil }
        let body: SRAuthResponseBody = try parser.responseBody(from: data)
        return body.token
    }
}
