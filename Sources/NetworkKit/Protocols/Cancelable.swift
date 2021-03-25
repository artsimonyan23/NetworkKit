//
//  Cancelable.swift
//  
//
//  Created by ArtS on 20.03.21.
//

import Foundation

public protocol Cancelable {
    func cancel()
}

extension URLSessionTask: Cancelable { }
