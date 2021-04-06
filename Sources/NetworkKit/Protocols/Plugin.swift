//
//  Plugin.swift
//
//
//  Created by ArtS on 24.03.21.
//

import Foundation

public protocol PluginType {
    func willSend(request: Requestable)
    func didReceive(response: Response)
    func modify(response: Response) -> Response
    func willReturn(response: Response)
}

public extension PluginType {
    func willSend(request: Requestable) { }
    func didReceive(response: Response) { }
    func modify(response: Response) -> Response {
        return response
    }
    func willReturn(response: Response) { }
}
