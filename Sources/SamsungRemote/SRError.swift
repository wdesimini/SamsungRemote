//
//  SRError.swift
//
//
//  Created by Wilson Desimini on 11/5/22.
//

import Foundation

public enum SRError: Error {
    case channelEvent(_ event: SRChannelEvent)
    case invalidResponse
    case missingToken
    case unexpectedAuthorization(token: SRToken)
}
