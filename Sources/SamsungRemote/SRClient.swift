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
    public let websocketFactory: SRWebSocketFactory
    private let decoder = JSONDecoder()

    public init(
        app: String,
        ipAddress: String,
        websocketFactory: SRWebSocketFactory
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
        return response.data?.token
    }
}
