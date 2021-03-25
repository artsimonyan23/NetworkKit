//
//  Encodable.swift
//
//
//  Created by ArtS on 1/21/19.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            #if DEBUG
            print("🔴NetworkKit: \(error) 🔴")
            #endif
        }
        return nil
    }
}
