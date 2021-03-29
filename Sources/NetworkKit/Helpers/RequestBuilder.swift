//
//  RequestBuilder.swift
//  
//
//  Created by ArtS on 29.03.21.
//

import Foundation

public struct RequestBuilder: Requestable {
    public let path: String
    public let method: HTTPMethod
    public let parameters: Parameter?
    public let headers: HTTPHeaders?
    public let environment: Environmental

    public init(path: String, method: HTTPMethod, parameters: Parameter? = nil, headers: HTTPHeaders? = nil, environment: Environmental) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.environment = environment
    }
}
