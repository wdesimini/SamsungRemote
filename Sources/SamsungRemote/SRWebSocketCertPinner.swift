//
//  SRWebSocketCertPinner.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation
import Starscream

class SRWebSocketCertPinner: CertificatePinning {
    func evaluateTrust(
        trust _: SecTrust,
        domain _: String?,
        completion: (Starscream.PinningState) -> Void
    ) {
        #warning("TODO: evaluate trust")
        completion(.success)
    }
}
