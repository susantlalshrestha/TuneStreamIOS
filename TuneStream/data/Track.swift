//
//  TrackDetails.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import Foundation

struct Track: Codable {
    let album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: ExternalUrls
    let href: String
    let id: String
    let is_local: Bool
    let name: String
    let popularity: Int?
    let preview_url: String?
    let track_number: Int
    let type: String
    let uri: String
    let duration_ms: Int
    let explicit: Bool
    let external_ids: ExternalIds?
}
