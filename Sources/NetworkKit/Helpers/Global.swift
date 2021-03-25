//
//  Global.swift
//
//
//  Created by ArtS on 26.03.21.
//

import Foundation

public typealias ResponseCompletion = () -> ()

public typealias ResponseCompletionWith<T> = (_ data: T) -> ()

public typealias ResponseErrorHandler = (_ error: Error?) -> ()

public typealias Response = (data: Data?, response: URLResponse?, error: Error?)
