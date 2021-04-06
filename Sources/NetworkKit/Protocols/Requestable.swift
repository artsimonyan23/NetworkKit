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

extension Requestable {
    func buildUrlRequest() -> URLRequest {
//        var path = self.path
//        if path.hasPrefix("/") {
//            path.removeFirst()
//        }
        guard var url = URL(string: environment.baseUrl) else { fatalError("Wrong URL") }
        url.appendPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { fatalError("Wrong URL") }
        if case let .query(queryItems) = parameters {
            components.queryItems = queryItems
        }
        guard let componentUrl = components.url else { fatalError("Wrong URL") }
        var urlRequest = URLRequest(url: componentUrl)
        urlRequest.httpMethod = method.rawValue
        headers?.forEach({ (header) in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.name)
        })
        if case let .httpBody(body) = parameters {
            urlRequest.httpBody = body.toJSONData()
        }
        return urlRequest
    }
    
    public func buildRequest() -> RequestBuilder {
        return RequestBuilder(path: path, method: method, parameters: parameters, headers: headers, environment: environment)
    }
    
    public func buildRequest<T: Decodable>() -> DecodableRequestBuilder<T> {
        return DecodableRequestBuilder(path: path, method: method, parameters: parameters, headers: headers, environment: environment)
    }
}

extension Requestable where Self: DecodableRequestable {
    public func buildRequest() -> DecodableRequestBuilder<Output> {
        return DecodableRequestBuilder(path: path, method: method, parameters: parameters, headers: headers, environment: environment)
    }
}
