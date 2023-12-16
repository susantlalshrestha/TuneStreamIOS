//
//  ArtistsVM.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import Foundation

protocol SearchArtistsDelegate {
    func onSearchArtitsSuccess(artists: [Artist])
    func onSearchArtitsFailed(error: String)
}

protocol GetArtistAlbumsDelegate {
    func onGetArtistAlbumsSuccess(albums: [Album])
    func onGetArtistAlbumsFailed(error: String)
}

protocol GetAlbumTracksDelegate {
    func onGetAlbumTracksSuccess(tracks: [Track])
    func onGetAlbumTracksFailed(error: String)
}

class ArtistsVM {
    
    private let spotifyApi: SpotifyApi
    var searchArtistsDelegate: SearchArtistsDelegate?
    var getArtistAlbumsDelegate: GetArtistAlbumsDelegate?
    var getAlbumTracksDelegate: GetAlbumTracksDelegate?
    
    init(spotifyApi: SpotifyApi) {
        self.spotifyApi = spotifyApi
    }
    
    func searchArtists(_ q: String) {
        Task.init {
            do {
                let searchArtistRP = try await spotifyApi.searchArtists(q)
                DispatchQueue.main.async {
                    self.searchArtistsDelegate?.onSearchArtitsSuccess(artists: searchArtistRP.artists.items)
                }
            } catch let error as APIError {
                DispatchQueue.main.async {
                    self.searchArtistsDelegate?.onSearchArtitsFailed(error: error.message)
                }
            } catch {
                DispatchQueue.main.async {
                    self.searchArtistsDelegate?.onSearchArtitsFailed(error: error.localizedDescription)
                }
            }
        }
    }
    
    func getArtistAlbums(artistID: String) {
        Task.init {
            do {
                let albumsRP = try await spotifyApi.getArtistAlbums(artistID: artistID)
                DispatchQueue.main.async {
                    self.getArtistAlbumsDelegate?.onGetArtistAlbumsSuccess(albums: albumsRP.items)
                }
            } catch let error as APIError {
                DispatchQueue.main.async {
                    self.getArtistAlbumsDelegate?.onGetArtistAlbumsFailed(error: error.message)
                }
            } catch {
                DispatchQueue.main.async {
                    self.getArtistAlbumsDelegate?.onGetArtistAlbumsFailed(error: error.localizedDescription)
                }
            }
        }
    }
    
    func getAlbumTracks(albumID: String) {
        Task.init {
            do {
                let albumTracksRP = try await spotifyApi.getAlbumTracks(albumID: albumID)
                DispatchQueue.main.async {
                    self.getAlbumTracksDelegate?.onGetAlbumTracksSuccess(tracks: albumTracksRP.items)
                }
            } catch let error as APIError {
                DispatchQueue.main.async {
                    self.getAlbumTracksDelegate?.onGetAlbumTracksFailed(error: error.message)
                }
            } catch {
                DispatchQueue.main.async {
                    self.getAlbumTracksDelegate?.onGetAlbumTracksFailed(error: error.localizedDescription)
                }
            }
        }
    }
}
