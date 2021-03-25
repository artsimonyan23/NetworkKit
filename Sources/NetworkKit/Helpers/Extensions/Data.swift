//
//  Data.swift
//  
//
//  Created by ArtS on 1/21/19.
//

import Foundation

extension Data {
    func decodeToJSON<T: Decodable>(with type: T.Type = T.self, completionHandler: ResponseCompletionWith<T>, errorHandler: ResponseErrorHandler? = nil) {
        do {
            let json = try JSONDecoder().decode(T.self, from: self)
            completionHandler(json)
        } catch {
            errorHandler?(error)
        }
    }
}
