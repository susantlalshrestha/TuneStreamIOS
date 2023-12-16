//
//  PlaylistsVM.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import Foundation

class PlaylistsVM {
    
    private let spotifyApi: SpotifyApi
    
    init(spotifyApi: SpotifyApi) {
        self.spotifyApi = spotifyApi
    }
    
    func getPlaylistsByCategory(categoryId: String) async -> ([Playlist], String?) {
        do {
            let playlistsRP = try await spotifyApi.getPlaylistsByCategory(categoryId: categoryId)
            return (playlistsRP.playlists.items, nil)
        } catch let error as APIError {
            return ([], error.message)
        } catch {
            return ([], error.localizedDescription)
        }
    }
    
    func getPlaylistTracks(url: String) async -> ([PlaylistTracks], String?) {
        do {
            let tracksRP = try await spotifyApi.getPlaylistsTracks(url: url)
            return (tracksRP.items, nil)
        } catch let error as APIError {
            return ([], error.message)
        } catch {
            return ([], error.localizedDescription)
        }
    }
}
