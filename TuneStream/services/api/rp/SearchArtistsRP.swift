//
//  SearchArtistsRP.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import Foundation

struct SearchArtistRP: Codable {
    let artists: ListRP<Artist>
}
