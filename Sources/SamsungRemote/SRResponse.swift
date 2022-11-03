//
//  SRResponse.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

public struct SRResponse<Body: Codable>: Codable {
    public let data: Body?
    public let event: String
}
