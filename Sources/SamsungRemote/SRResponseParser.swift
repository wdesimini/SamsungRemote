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
        let response: SRResponse<Body> = try decoder
            .decode(SRResponse<Body>.self, from: data)
        guard response.data != nil else {
            throw SRError.channelEvent(response.event)
        }
        return response
    }
}
