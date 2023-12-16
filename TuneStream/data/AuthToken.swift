//
//  AuthToken.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import Foundation

struct AuthToken: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}
