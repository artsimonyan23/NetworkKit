//
//  Uploadable.swift
//
//
//  Created by ArtS on 20.03.21.
//

import Foundation

public protocol Uploadable: Requestable {
    var uploadData: Data { get }
}
