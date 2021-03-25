//
//  DecodableRequestable.swift
//
//
//  Created by ArtS on 26.03.21.
//

import Foundation

public protocol DecodableRequestable: Requestable {
    associatedtype Output: Decodable
}
