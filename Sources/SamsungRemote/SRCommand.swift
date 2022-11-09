//
//  SRCommand.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import Foundation

public struct SRCommand: Codable {
    public struct Params: Codable {
        public let cmd: String
        public let dataOfCmd: SRRemoteKey
        public let option: Bool
        public let typeOfRemote: SRRemoteType

        enum CodingKeys: String, CodingKey {
            case cmd = "Cmd"
            case dataOfCmd = "DataOfCmd"
            case option = "Option"
            case typeOfRemote = "TypeOfRemote"
        }

        public init(
            cmd: String,
            dataOfCmd: SRRemoteKey,
            option: Bool,
            typeOfRemote: SRRemoteType
        ) {
            self.cmd = cmd
            self.dataOfCmd = dataOfCmd
            self.option = option
            self.typeOfRemote = typeOfRemote
        }
    }

    public let method: String
    public let params: Params

    public init(method: String, params: Params) {
        self.method = method
        self.params = params
    }
}
