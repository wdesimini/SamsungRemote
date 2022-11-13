//
//  SRChannelEmitCommand.swift
//
//
//  Created by Wilson Desimini on 11/13/22.
//

import Foundation

public struct SRChannelEmitCommand: Codable {
    public struct Params: Codable {
        public enum AppActionType: String, Codable {
            case deepLink = "DEEP_LINK"
            case nativeLaunch = "NATIVE_LAUNCH"
        }

        public struct AppData: Codable {
            public let actionType: AppActionType
            public let appID: String
            public let metaTag: String?

            public enum CodingKeys: String, CodingKey {
                case actionType = "action_type"
                case appID = "appId"
                case metaTag = "metaTag"
            }

            public init(
                actionType: AppActionType,
                appID: String,
                metaTag: String?
            ) {
                self.actionType = actionType
                self.appID = appID
                self.metaTag = metaTag
            }
        }

        public enum Event: String, Codable {
            case apps = "ed.installedApp.get"
            case launchApp = "ed.apps.launch"
        }

        public let data: AppData?
        public let event: Event
        public let to: String
    }

    public let method: String
    public let params: Params

    public init(params: Params) {
        method = "ms.channel.emit"
        self.params = params
    }
}
