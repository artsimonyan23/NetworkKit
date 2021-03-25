//
//  Requestable.swift
//
//
//  Created by ArtS on 20.03.21.
//

import Foundation

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameter? { get }
    var headers: HTTPHeaders? { get }
    var environment: Environmental { get }
}

public extension Requestable {
    var parameters: Parameter? {
        return nil
    }

    var headers: HTTPHeaders? {
        return nil
    }
}

extension Requestable {
    func build() -> URLRequest {
        guard var components = URLComponents(string: environment.baseUrl) else { fatalError("Wrong Base URL") }
        components.path += path
        if case let .query(queryItems) = parameters {
            components.queryItems = queryItems
        }
        guard let url = components.url else { fatalError("Wrong URL Path") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if case let .httpBody(body) = parameters {
            urlRequest.httpBody = body.toJSONData()
        }
        return urlRequest
    }
}
