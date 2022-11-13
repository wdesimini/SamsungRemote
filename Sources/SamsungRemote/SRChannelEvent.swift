//
//  SRChannelEvent.swift
//
//
//  Created by Wilson Desimini on 11/4/22.
//

import Foundation

public enum SRChannelEvent: String, Codable {
    case appLaunch = "ed.apps.launch"
    case appsRequest = "ed.installedApp.get"
    case connect = "ms.channel.connect"
    case disconnect = "ms.channel.disconnect"
    case clientConnect = "ms.channel.clientConnect"
    case clientDisconnect = "ms.channel.clientDisconnect"
    case data = "ms.channel.data"
    case emit = "ms.channel.emit"
    case error = "ms.channel.error"
    case message = "ms.channel.message"
    case ping = "ms.channel.ping"
    case ready = "ms.channel.ready"
    case timeout = "ms.channel.timeOut"
    case unauthorized = "ms.channel.unauthorized"
}
