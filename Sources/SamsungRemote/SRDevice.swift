//
//  SRDevice.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

public struct SRDevice: Codable, Identifiable {
    public struct Attributes: Codable {
        public let name: String?
        public let token: SRToken?
    }

    public let attributes: Attributes
    public let connectTime: Int
    public let deviceName, id: String
    public let isHost: Bool

    public init(
        attributes: Attributes,
        connectTime: Int,
        deviceName: String,
        id: String,
        isHost: Bool
    ) {
        self.attributes = attributes
        self.connectTime = connectTime
        self.deviceName = deviceName
        self.id = id
        self.isHost = isHost
    }
}
