//
//  Parameter.swift
//  
//
//  Created by ArtS on 22.03.21.
//

import Foundation

public enum Parameter {
    case query([URLQueryItem])
    case httpBody(Encodable)
}
