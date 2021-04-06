//
//  DefaultDispatcher.swift
//
//
//  Created by ArtS on 24.03.21.
//

import Foundation

public struct DefaultDispatcher: NetworkDispatcher {
    private let session: URLSession

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public init(sessionConfig: URLSessionConfiguration) {
        self.session = URLSession(configuration: sessionConfig)
    }
    
    public func execute(request: Requestable, callbackQueue: DispatchQueue, completion: @escaping ResponseCompletionWith<Response>) -> Cancelable {
        let dataTask = session.dataTask(with: request.buildUrlRequest()) { (data, response, error) in
            callbackQueue.async {
                completion((data, response, error))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
