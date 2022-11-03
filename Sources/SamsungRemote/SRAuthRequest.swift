//
//  SRAuthRequest.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

public struct SRAuthRequest: SRRequest {
    public let app: String
    public let endpoint = "/api/v2/channels/samsung.remote.control"
    public let ipAddress: String
    public let port = 8002
    public let scheme = "wss"

    public var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = ipAddress
        components.path = endpoint
        components.port = port
        var items = [URLQueryItem]()
        items.append(.init(name: "name", value: app))
        components.queryItems = items
        return components.url!.removingPercentEncoding!
    }
}
