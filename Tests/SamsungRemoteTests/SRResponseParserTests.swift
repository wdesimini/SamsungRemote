//
//  SRResponseParserTests.swift
//
//
//  Created by Wilson Desimini on 11/8/22.
//

import XCTest
@testable import SamsungRemote

final class SRResponseParserTests: XCTestCase {
    private let parser = SRResponseParser()

    func testAuthResponseBody() throws {
        let data = try Bundle.module.data("auth_approved")
        let body: SRAuthResponseBody = try parser.responseBody(from: data)
        XCTAssertEqual(body.token, "11111111")
    }

    func testAuthResponseError() throws {
        let data = try Bundle.module.data("auth_cancelled")
        do {
            let _: SRAuthResponseBody = try parser.responseBody(from: data)
            XCTFail()
        } catch let SRError.channelEvent(event) {
            XCTAssertEqual(event, .timeout)
        } catch {
            XCTFail()
        }
    }
}
