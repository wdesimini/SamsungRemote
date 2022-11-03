//
//  SRWebSocketFactory.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Starscream

public struct SRWebSocketFactory {
    public let pinner: CertificatePinning

    public init(pinner: CertificatePinning? = nil) {
        self.pinner = pinner ?? SRWebSocketCertPinner()
    }

    public func websocket(from request: SRRequest) -> WebSocket {
        WebSocket(
            request: request.urlRequest,
            certPinner: pinner
        )
    }
}
