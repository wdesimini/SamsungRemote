//
//  SRWebSocketFactory.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Starscream

// MARK: - SRWebSocketFactoryProtocol

public protocol SRWebSocketFactoryProtocol {
    func websocket(from request: any SRRequest) -> WebSocket
}

// MARK: - SRWebSocketFactory

public struct SRWebSocketFactory: SRWebSocketFactoryProtocol {
    public let pinner: CertificatePinning

    public init(pinner: CertificatePinning? = nil) {
        self.pinner = pinner ?? SRWebSocketCertPinner()
    }

    public func websocket(from request: any SRRequest) -> WebSocket {
        WebSocket(
            request: request.urlRequest,
            certPinner: pinner
        )
    }
}
