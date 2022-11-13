//
//  SRResponseParser.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

public struct SRResponseParser {
    private let decoder = JSONDecoder()

    public func response<Body: Decodable>(
        from data: Data
    ) throws -> SRResponse<Body> {
        if let authResponse: SRAuthRequest.Response = try? decoder
            .decode(SRAuthRequest.Response.self, from: data),
            let token = authResponse.data?.token,
            SRResponse<Body>.self != SRAuthRequest.Response.self {
            throw SRError.unexpectedAuthorization(token: token)
        } else if let response: SRResponse<Body> = try? decoder
            .decode(SRResponse<Body>.self, from: data) {
            if response.data != nil {
                return response
            } else {
                throw SRError.channelEvent(response.event)
            }
        } else {
            throw SRError.invalidResponse
        }
    }
}
