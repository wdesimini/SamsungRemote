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
    private let decoder = JSONDecoder()

    public init(
        app: String,
        ipAddress: String,
        websocketFactory: SRWebSocketFactoryProtocol
    ) {
        self.app = app
        self.ipAddress = ipAddress
        self.websocketFactory = websocketFactory
    }

    public func auth() async throws -> String? {
        let request = SRAuthRequest(app: app, ipAddress: ipAddress)
        let websocket = websocketFactory.websocket(from: request)
        guard let data = try await websocket.connectUntilBody()
        else { return nil }
        let response = try decoder.decode(SRAuthResponse.self, from: data)
        guard let data = response.data else {
            throw SRError.channelEvent(response.event)
        }
        return data.token
    }
}
