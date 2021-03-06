//
//  Provider.swift
//
//
//  Created by ArtS on 24.03.21.
//

import Foundation

public struct Provider<T: Requestable> {
    private let dispatcher: NetworkDispatcher
    private let callbackQueue: DispatchQueue
    private let plugins: [PluginType]?

    public init(dispatcher: NetworkDispatcher = DefaultDispatcher(), callbackQueue: DispatchQueue = .main, plugins: [PluginType]? = nil) {
        self.dispatcher = dispatcher
        self.callbackQueue = callbackQueue
        self.plugins = plugins
    }

    @discardableResult
    public func request(_ request: T, completionHandler: @escaping ResponseCompletionWith<Data>, errorHandler: ResponseErrorHandler? = nil) -> Cancelable {
        plugins?.forEach({ $0.willSend(request: request) })
        return dispatcher.execute(request: request, callbackQueue: callbackQueue) { response in
            plugins?.forEach({ $0.didReceive(response: response) })
            let response = plugins?.reduce(response) { $1.modify(response: $0) } ?? response
            if let data = response.data {
                plugins?.forEach({ $0.willReturn(response: response) })
                completionHandler(data)
            } else {
                plugins?.forEach({ $0.willReturn(response: (data: nil, response: response.response, error: response.error)) })
                errorHandler?(response.error)
            }
        }
    }

    @discardableResult
    public func request(_ request: T, completionHandler: @escaping ResponseCompletion, errorHandler: ResponseErrorHandler? = nil) -> Cancelable {
        self.request(request, completionHandler: { _ in
            completionHandler()
        }, errorHandler: errorHandler)
    }

    @discardableResult
    public func request<Data>(_ request: T, decodder: @escaping DataWrapper<Data>, completionHandler: @escaping ResponseCompletionWith<Data>, errorHandler: ResponseErrorHandler? = nil) -> Cancelable {
        plugins?.forEach({ $0.willSend(request: request) })
        return dispatcher.execute(request: request, callbackQueue: callbackQueue) { response in
            plugins?.forEach({ $0.didReceive(response: response) })
            let response = plugins?.reduce(response) { $1.modify(response: $0) } ?? response
            if let data = response.data {
                decodder(data, { data in
                    plugins?.forEach({ $0.willReturn(response: response) })
                    completionHandler(data)
                }, { error in
                    plugins?.forEach({ $0.willReturn(response: (data: nil, response: response.response, error: error)) })
                    errorHandler?(error)
                })
            } else {
                plugins?.forEach({ $0.willReturn(response: (data: nil, response: response.response, error: response.error)) })
                errorHandler?(response.error)
            }
        }
    }

    @discardableResult
    public func requestDecodable<Data: Decodable>(_ request: T, completionHandler: @escaping ResponseCompletionWith<Data>, errorHandler: ResponseErrorHandler? = nil) -> Cancelable {
        self.request(request, decodder: decodableWrapper, completionHandler: completionHandler, errorHandler: errorHandler)
    }

    @discardableResult
    public func requestDecodable(_ request: T, completionHandler: @escaping ResponseCompletionWith<T.Output>, errorHandler: ResponseErrorHandler? = nil) -> Cancelable where T: DecodableRequestable {
        self.request(request, decodder: decodableWrapper, completionHandler: completionHandler, errorHandler: errorHandler)
    }

    private func decodableWrapper<T: Decodable>(_ data: Data, _ completionHandler: @escaping ResponseCompletionWith<T>, _ errorHandler: ResponseErrorHandler?) {
        data.decodeToJSON(with: T.self, completionHandler: completionHandler, errorHandler: errorHandler)
    }
}
