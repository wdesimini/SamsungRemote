//
//  SRWebSocketMockFactory.swift
//
//
//  Created by Wilson Desimini on 11/3/22.
//

import Foundation
import SamsungRemote
import Starscream

// MARK: - SRWebSocketMockFactory

struct SRWebSocketMockFactory: SRWebSocketFactoryProtocol {
    let events: [WebSocketEvent]

    func websocket(from _: SRRequest) -> WebSocket {
        SRWebSocketMock(events: events)
    }
}

// MARK: - SRWebSocketMock

class SRWebSocketMock: WebSocket {
    init(events: [WebSocketEvent]) {
        super.init(
            request: .mock,
            engine: EngineMock(events: events)
        )
    }
}

extension URLRequest {
    fileprivate static var mock: URLRequest {
        let urlStr = "https://www.google.com/"
        let url = URL(string: urlStr)!
        return URLRequest(url: url)
    }
}

// MARK: - SRWebSocketMock.EngineMock

extension SRWebSocketMock {
    fileprivate class EngineMock {
        private let events: [WebSocketEvent]
        private weak var delegate: EngineDelegate!

        fileprivate init(events: [WebSocketEvent]) {
            self.events = events
        }
    }
}

// MARK: - SRWebSocketMock.EngineMock + Engine

extension SRWebSocketMock.EngineMock: Engine {
    private func executeEvents() {
        events.forEach(delegate.didReceive(event:))
    }

    func register(delegate: EngineDelegate) {
        self.delegate = delegate
    }

    func start(request _: URLRequest) {
        executeEvents()
    }

    func stop(closeCode _: UInt16) {
    }

    func forceStop() {
    }

    func write(data: Data, opcode: FrameOpCode, completion: (() -> Void)?) {
        print(data)
        print(opcode)
        completion?()
    }

    func write(string: String, completion: (() -> Void)?) {
        print(string)
        completion?()
    }
}
