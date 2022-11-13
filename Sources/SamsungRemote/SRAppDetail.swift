//
//  SRAppDetail.swift
//
//
//  Created by Wilson Desimini on 11/13/22.
//

import Foundation

public struct SRAppDetail: Codable {
    public let appID: String
    public let appType: Int
    public let icon: String
    public let isLock: Int
    public let name: String

    enum CodingKeys: String, CodingKey {
        case appID = "appId"
        case appType = "app_type"
        case icon
        case isLock = "is_lock"
        case name
    }

    public init(
        appID: String,
        appType: Int,
        icon: String,
        isLock: Int,
        name: String
    ) {
        self.appID = appID
        self.appType = appType
        self.icon = icon
        self.isLock = isLock
        self.name = name
    }
}
