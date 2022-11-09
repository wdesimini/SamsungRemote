//
//  SRAuthRequest.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

public struct SRAuthRequest: SRRequest {
    public let config: SRConfig

    init(app: String, ipAddress: String) {
        config = .secure(app: app, ipAddress: ipAddress)
    }
}
