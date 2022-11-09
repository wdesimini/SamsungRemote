//
//  SRResponseParser.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

public struct SRResponseParser {
    private let decoder = JSONDecoder()

    public func responseBody<T>(
        from data: Data
    ) throws -> T where T: Codable {
        let response = try decoder.decode(
            SRResponse<T>.self,
            from: data
        )
        guard let body = response.data else {
            throw SRError.channelEvent(response.event)
        }
        return body
    }
}
