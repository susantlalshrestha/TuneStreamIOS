//
//  User.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import Foundation

struct User: Codable {
    let display_name: String
    let external_urls: ExternalUrls
    let followers: AdditionalLinks?
    let href: String
    let id: String
    let images: [Image]?
    let type: String
    let uri: String
}
