//
//  DataWrapper.swift
//
//
//  Created by ArtS on 26.03.21.
//

import Foundation

public typealias DataWrapper<T> = (_ data: Data, _ completionHandler: @escaping ResponseCompletionWith<T>, _ errorHandler: ResponseErrorHandler?) -> ()?
