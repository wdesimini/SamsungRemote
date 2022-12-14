//
//  SRRequest.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

// MARK: - SRRequest

public protocol SRRequest {
    associatedtype ResponseBody: Codable
    typealias Response = SRResponse<ResponseBody>
    var config: SRConfig { get }
    var body: String? { get }
}

extension SRRequest {
    public var body: String? {
        nil
    }

    public var urlRequest: URLRequest {
        .init(url: config.url)
    }
}
