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
}

public extension PluginType {
    func willSend(request: Requestable) { }
    func didReceive(result: Result<Data, Error>) { }
}
