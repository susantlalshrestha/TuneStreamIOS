//
//  APIError.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import Foundation

class APIError: LocalizedError {
    public let message: String
    init(_ message: String) {
        self.message = message
    }
}
