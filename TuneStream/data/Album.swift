//
//  Album.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import Foundation

struct Album: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let release_date: String
    let release_date_precision: String
    let total_tracks: Int
    let type: String
    let uri: String
}
