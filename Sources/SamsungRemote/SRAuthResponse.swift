//
//  SRAuthResponse.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

public typealias SRAuthResponse = SRResponse<SRAuthResponseBody>

// MARK: - SRAuthResponseBody

public struct SRAuthResponseBody: Codable {
    public let clients: [SRDevice]
    public let id: String
    public let token: SRToken
}
