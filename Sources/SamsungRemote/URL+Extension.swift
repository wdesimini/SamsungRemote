//
//  URL+Extension.swift
//
//
//  Created by Wilson Desimini on 11/2/22.
//

import Foundation

extension URL {
    var removingPercentEncoding: URL? {
        absoluteString.removingPercentEncoding.flatMap(URL.init(string:))
    }
}
