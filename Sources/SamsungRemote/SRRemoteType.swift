//
//  SRRemoteType.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

public enum SRRemoteType: String, Codable {
    case inputEnd = "SendInputEnd"
    case inputString = "SendInputString"
    case mouseDevice = "ProcessMouseDevice"
    case remoteKey = "SendRemoteKey"
}
