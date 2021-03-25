//
//  NetworkDispatcher.swift
//
//
//  Created by ArtS on 24.03.21.
//

import Foundation

public protocol NetworkDispatcher {
    init(session: URLSession)
    func execute(request: Requestable, callbackQueue: DispatchQueue, completion: @escaping ResponseCompletionWith<Response>) -> Cancelable
}
