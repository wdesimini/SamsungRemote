//
//  SRClientTests.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import XCTest
import Starscream
@testable import SamsungRemote

@available(iOS 13.0, macOS 10.15, *)
final class SRClientTests: XCTestCase {
    private let app = "SamsungRemoteApp"
    private let ipAddress = "192.168.0.21"
    private var client: SRClient!
    private var token: SRToken?

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        client = nil
    }

    private func injectMockEvents(_ events: [WebSocketEvent]) {
        client = .init(
            app: app,
            ipAddress: ipAddress,
            token: token,
            websocketFactory: SRWebSocketMockFactory(
                events: events
            )
        )
    }

    func testApps() async throws {
        // given
        token = "11111111"
        injectMockEvents([
            .viabilityChanged(true),
            .connectedMock,
            try .textMock("apps"),
            .cancelled
        ])
        // when
        let apps = try await client.apps()
        // then
        XCTAssertNotNil(apps)
    }

    func testAuthAllowed() async throws {
        // given
        injectMockEvents([
            .viabilityChanged(true),
            .connectedMock,
            try .textMock("auth_approved"),
            .cancelled,
        ])
        // when
        let token = try await client.auth()
        // then
        XCTAssertEqual(token, "11111111")
    }

    func testAuthCancelled() async throws {
        // given
        injectMockEvents([
            .viabilityChanged(true),
            .connectedMock,
            try .textMock("auth_cancelled"),
            .cancelled,
        ])
        // when
        var authError: Error?
        do { let _ = try await client.auth() }
        catch { authError = error }
        // then
        if case let .channelEvent(event) = authError as? SRError {
            XCTAssertEqual(event, .timeout)
        } else {
            XCTFail()
        }
    }

    func testAuthDenied() async throws {
        // given
        injectMockEvents([
            .viabilityChanged(true),
            .connectedMock,
            try .textMock("auth_denied"),
            .cancelled,
        ])
        // when
        var authError: Error?
        do { let _ = try await client.auth() }
        catch { authError = error }
        // then
        if case let .channelEvent(event) = authError as? SRError {
            XCTAssertEqual(event, .unauthorized)
        } else {
            XCTFail()
        }
    }

    func testKeySuccess() async throws {
        // given
        token = "11111111"
        injectMockEvents([
            .viabilityChanged(true),
            .connectedMock,
            try .textMock("key_success"),
            .cancelled,
        ])
        // when
        let body = try await client.key(.mute)
        // then
        XCTAssertEqual(body?.clients.first?.attributes.token, token)
    }

    func testUnexpectedAuthorization() async throws {
        // given
        token = "11111112"
        injectMockEvents([
            .viabilityChanged(true),
            .connectedMock,
            try .textMock("auth_approved"),
            .cancelled,
        ])
        // when
        do {
            let _ = try await client.key(.mute)
            XCTFail()
        } catch let SRError.unexpectedAuthorization(tokenReceived) {
            XCTAssertNotEqual(tokenReceived, token)
        } catch {
            XCTFail()
        }
    }
}
