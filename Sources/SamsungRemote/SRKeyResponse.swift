//
//  SRKeyResponse.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

public typealias SRKeyResponse = SRResponse<SRKeyResponseBody>

// MARK: - SRKeyResponseBody

public struct SRKeyResponseBody: Codable {
    public let clients: [SRDevice]
    public let id: String
}
