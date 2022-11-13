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

    func testAppsResponseBody() throws {
        let data = try Bundle.module.data("apps")
        let response: SRAppRequest.Response = try parser.response(from: data)
        XCTAssertNotNil(response.data?.data)
        XCTAssertFalse(response.data!.data.isEmpty)
        XCTAssertEqual(response.data!.data[0].name, "YouTube")
    }

    func testAuthResponseBody() throws {
        let data = try Bundle.module.data("auth_approved")
        let response: SRAuthRequest.Response = try parser.response(from: data)
        XCTAssertEqual(response.data?.token, "11111111")
    }

    func testAuthResponseError() throws {
        let data = try Bundle.module.data("auth_cancelled")
        do {
            let _: SRAuthRequest.Response = try parser.response(from: data)
            XCTFail()
        } catch let SRError.channelEvent(event) {
            XCTAssertEqual(event, .timeout)
        } catch {
            XCTFail()
        }
    }
}
