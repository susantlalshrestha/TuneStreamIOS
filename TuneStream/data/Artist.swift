//
//  Artist.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import Foundation

struct Artist: Codable {
    let external_urls: ExternalUrls
    let followers: AdditionalLinks?
    let genres: [String]?
    let href: String
    let id: String
    let images: [Image]?
    let name: String
    let popularity: Int?
    let type: String
    let uri: String
}
