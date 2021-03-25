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
    public func request<Wrapper: ResponseWrapper>(_ request: T, wrapperType: Wrapper.Type = Wrapper.self, competionHandler: @escaping ResponseCompletionWith<Wrapper.Data>, errorHandler: ResponseErrorHandler? = nil) -> Cancelable {
        plugins?.forEach({ $0.willSend(request: request) })
        return dispatcher.execute(request: request, callbackQueue: callbackQueue) { response in
            Wrapper(response: response).getData(competionHandler: { data in
                plugins?.forEach({ $0.didReceive(response: response) })
                competionHandler(data)
            }, errorHandler: { error in
                plugins?.forEach({ $0.didReceive(response: (data: response.data, response: response.response, error: error)) })
                errorHandler?(error)
            })
            plugins?.forEach({ $0.didReceive(response: response) })
        }
    }
    
    @discardableResult
    public func request<Wrapper: ResponseWrapper>(_ request: T, wrapperType: Wrapper.Type = Wrapper.self, competionHandler: @escaping ResponseCompletion, errorHandler: ResponseErrorHandler? = nil) -> Cancelable {
        plugins?.forEach({ $0.willSend(request: request) })
        return dispatcher.execute(request: request, callbackQueue: callbackQueue) { response in
            Wrapper(response: response).getData(competionHandler: { data in
                plugins?.forEach({ $0.didReceive(response: response) })
                competionHandler()
            }, errorHandler: { error in
                plugins?.forEach({ $0.didReceive(response: (data: response.data, response: response.response, error: error)) })
                errorHandler?(error)
            })
            plugins?.forEach({ $0.didReceive(response: response) })
        }
    }
    
    @discardableResult
    public func request(_ request: T, competion: ResponseCompletionWith<Response>) -> Cancelable {
        plugins?.forEach({$0.willSend(request: request)})
        return dispatcher.execute(request: request, callbackQueue: callbackQueue) { (response) in
            plugins?.forEach({$0.didReceive(response: response)})

        }
    }
}
