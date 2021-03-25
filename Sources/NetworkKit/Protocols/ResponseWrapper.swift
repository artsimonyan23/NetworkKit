//
//  ResponseWrapper.swift
//
//
//  Created by ArtS on 26.03.21.
//

import Foundation

public protocol ResponseWrapper {
    associatedtype Data
    init(response: Response)
    func getData(competionHandler: @escaping ResponseCompletionWith<Data>, errorHandler: ResponseErrorHandler?)
}
