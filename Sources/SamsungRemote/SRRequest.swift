//
//  SRRequest.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

// MARK: - SRRequest

public protocol SRRequest {
    var url: URL { get }
}

extension SRRequest {
    public var urlRequest: URLRequest {
        .init(url: url)
    }
}
