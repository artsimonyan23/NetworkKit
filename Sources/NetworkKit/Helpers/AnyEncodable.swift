//
//  AnyEncodable.swift
//
//
//  Created by ArtS on 29.03.21.
//

import Foundation

public struct AnyEncodable: Encodable {
    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    public func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
