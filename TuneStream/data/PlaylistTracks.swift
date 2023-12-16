//
//  Track.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import Foundation

struct PlaylistTracks: Codable {
    let added_at: String
    let added_by: User
    let is_local: Bool
    let primary_color: String?
    let track: Track
    let video_thumbnail: VideoThumbnail?
}
