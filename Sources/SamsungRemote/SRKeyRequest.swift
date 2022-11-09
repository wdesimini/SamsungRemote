//
//  SRKeyRequest.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

public struct SRKeyRequest: SRRequest {
    public let app: String
    public let command: SRCommand
    public let endpoint = "/api/v2/channels/samsung.remote.control"
    public let ipAddress: String
    public let port = 8002
    public let scheme = "wss"
    public let token: SRToken

    public var body: String? {
        try? command.asString()
    }

    public var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = ipAddress
        components.path = endpoint
        components.port = port
        var items = [URLQueryItem]()
        items.append(.init(name: "name", value: app))
        items.append(.init(name: "token", value: token))
        components.queryItems = items
        return components.url!.removingPercentEncoding!
    }
}
