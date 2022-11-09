//
//  SRConfig.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

// MARK: - SRConfig

public struct SRConfig {
    public let app: String?
    public let endpoint: String
    public let ipAddress: String
    public let port: Int
    public let scheme: String
    public let token: String?

    public var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = ipAddress
        components.path = endpoint
        components.port = port
        components.queryItems = urlQueryItems
        return components.url!.removingPercentEncoding!
    }

    public var urlQueryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        items.append(.init(name: "name", value: app?.asBase64))
        items.append(.init(name: "token", value: token))
        items.removeAll { $0.value == nil }
        return !items.isEmpty ? items : nil
    }
}

extension SRConfig {
    public static func secure(
        app: String,
        ipAddress: String,
        token: SRToken? = nil
    ) -> SRConfig {
        .init(
            app: app,
            endpoint: "/api/v2/channels/samsung.remote.control",
            ipAddress: ipAddress,
            port: 8002,
            scheme: "wss",
            token: token
        )
    }
}
