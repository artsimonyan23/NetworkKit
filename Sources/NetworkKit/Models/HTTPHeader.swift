//
//  HTTPHeader.swift
//
//
//  Created by ArtS on 22.03.21.
//

import Foundation

public struct HTTPHeader {
    let name: String
    let value: String
}

public typealias HTTPHeaders = [HTTPHeader]

public extension HTTPHeaders {
    mutating func add(name: String, value: String) {
        append(HTTPHeader(name: name, value: value))
    }

    mutating func addBearerToken(_ token: String) {
        append(HTTPHeader(name: "Authorization", value: "Bearer \(token)"))
    }

    mutating func accept(_ value: String) {
        append(HTTPHeader(name: "Accept", value: value))
    }

    mutating func acceptCharset(_ value: String) {
        append(HTTPHeader(name: "Accept-Charset", value: value))
    }

    mutating func acceptLanguage(_ value: String) {
        append(HTTPHeader(name: "Accept-Language", value: value))
    }

    mutating func acceptEncoding(_ value: String) {
        append(HTTPHeader(name: "Accept-Encoding", value: value))
    }

    mutating func authorization(username: String, password: String) {
        let credential = Data("\(username):\(password)".utf8).base64EncodedString()
        authorization("Basic \(credential)")
    }

    mutating func authorization(bearerToken: String) {
        authorization("Bearer \(bearerToken)")
    }

    mutating func authorization(_ value: String) {
        append(HTTPHeader(name: "Authorization", value: value))
    }

    mutating func contentDisposition(_ value: String) {
        append(HTTPHeader(name: "Content-Disposition", value: value))
    }

    mutating func contentType(_ value: String) {
        append(HTTPHeader(name: "Content-Type", value: value))
    }

    mutating func userAgent(_ value: String) {
        append(HTTPHeader(name: "User-Agent", value: value))
    }

    var dictionary: [String: String] {
        let namesAndValues = map { ($0.name, $0.value) }
        return Dictionary(namesAndValues, uniquingKeysWith: { _, last in last })
    }
}
