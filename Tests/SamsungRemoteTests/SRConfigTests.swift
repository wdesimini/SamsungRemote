//
//  SRConfigTests.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import XCTest
@testable import SamsungRemote

final class SRConfigTests: XCTestCase {
    private var config: SRConfig!

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        config = nil
    }

    func testURL() throws {
        // when
        config = .init(
            app: nil,
            endpoint: "/api/v2",
            ipAddress: "192.168.0.1",
            port: 8001,
            scheme: "http",
            token: nil
        )
        // then
        XCTAssertEqual(
            config.url.absoluteString,
            "http://192.168.0.1:8001/api/v2"
        )
    }

    func testURLWithName() throws {
        // when
        config = .init(
            app: "WillyRemote",
            endpoint: "/api/v2",
            ipAddress: "192.168.0.1",
            port: 8001,
            scheme: "http",
            token: nil
        )
        // then
        XCTAssertEqual(
            config.url.absoluteString,
            "http://192.168.0.1:8001/api/v2"
                + "?name=V2lsbHlSZW1vdGU="
        )
    }

    func testURLWithNameAndToken() throws {
        // when
        config = .init(
            app: "WillyRemote",
            endpoint: "/api/v2",
            ipAddress: "192.168.0.1",
            port: 8001,
            scheme: "http",
            token: "11111111"
        )
        // then
        XCTAssertEqual(
            config.url.absoluteString,
            "http://192.168.0.1:8001/api/v2"
                + "?name=V2lsbHlSZW1vdGU="
                + "&token=11111111"
        )
    }
}
