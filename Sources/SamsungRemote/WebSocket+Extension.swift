//
//  WebSocket+Extension.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation
import Starscream

extension WebSocket {
    @available(macOS 10.15, *) func connectUntilBody(
        write: String? = nil
    ) async throws -> Data? {
        try await withCheckedThrowingContinuation { continuation in
            var result: Result<Data?, Error> = .success(nil)
            onEvent = { [weak self] event in
                if let body = event.body {
                    result = .success(body)
                    let group = DispatchGroup()
                    if let write = write {
                        group.enter()
                        self?.write(string: write) {
                            group.leave()
                        }
                    }
                    group.notify(queue: .main) {
                        self?.disconnect()
                    }
                } else if case let .error(error) = event {
                    error.flatMap { result = .failure($0) }
                    self?.disconnect()
                } else if case .cancelled = event {
                    continuation.resume(with: result)
                }
            }
            connect()
        }
    }
}
