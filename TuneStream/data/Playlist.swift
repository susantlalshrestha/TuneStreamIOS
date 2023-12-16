//
//  Playlist.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import Foundation


struct Playlist : Codable {
    let collaborative: Bool
    let description: String
    let external_urls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let owner: User
    let snapshot_id: String
    let tracks: AdditionalLinks
    let type: String
    let uri: String
    let primary_color: String?
}
