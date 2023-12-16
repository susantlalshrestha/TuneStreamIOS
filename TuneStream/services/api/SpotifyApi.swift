//
//  SpotifyApi.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import Foundation

class SpotifyApi {
    private final let clientId = "eab3cd19edbe4817b0336292e613a34d"
    private final let clientSecret = "18b91dda35734bcabc9ab1267e1bdc18"
    
    private var authToken : AuthToken?
    
    func getToken() async {
        print("HELLO 2")
        guard let url = URL(string: "https://accounts.spotify.com/api/token") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let token = "\(clientId):\(clientSecret)".data(using: .utf8)?.base64EncodedString() else { return }
        request.addValue("Basic \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if !(200...299).contains(httpResponse.statusCode) {
                print("HTTPError \(httpResponse.statusCode)")
                return
            }
            
            let decoder = JSONDecoder()
            let authToken = try decoder.decode(AuthToken.self, from: data)
            self.authToken = authToken
            print(authToken.access_token)
        } catch {
            print("NetworkError")
        }
    }
    
    func searchArtists(_ q: String) async throws -> SearchArtistRP {
        guard let url = URL(string: "https://api.spotify.com/v1/search?q=\(q.replacingOccurrences(of: " ", with: "+"))&type=artist") else { throw APIError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if authToken == nil { await getToken() }
        
        request.addValue("Bearer \(authToken!.access_token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw APIError("HTTP Error") }
            if !(200...299).contains(httpResponse.statusCode) { throw APIError("HTTPError \(httpResponse.statusCode)") }
            
            let decoder = JSONDecoder()
            let searchArtistRP = try decoder.decode(SearchArtistRP.self, from: data)
            print(searchArtistRP.artists.total)
            return searchArtistRP
        } catch {
            throw APIError(error.localizedDescription)
        }
    }
    
    func getArtistAlbums(artistID: String) async throws -> ListRP<Album> {
        guard let url = URL(string: "https://api.spotify.com/v1/artists/\(artistID)/albums") else { throw APIError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if authToken == nil { await getToken() }
        
        request.addValue("Bearer \(authToken!.access_token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw APIError("HTTP Error") }
            if !(200...299).contains(httpResponse.statusCode) { throw APIError("HTTPError \(httpResponse.statusCode)") }
            
            let decoder = JSONDecoder()
            let albumsRP = try decoder.decode(ListRP<Album>.self, from: data)
            print(albumsRP.total)
            return albumsRP
        } catch {
            print(error)
            throw APIError(error.localizedDescription)
        }
    }
    
    func getAlbumTracks(albumID: String) async throws -> ListRP<Track> {
        guard let url = URL(string: "https://api.spotify.com/v1/albums/\(albumID)/tracks") else { throw APIError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if authToken == nil { await getToken() }
        
        request.addValue("Bearer \(authToken!.access_token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw APIError("HTTP Error") }
            if !(200...299).contains(httpResponse.statusCode) { throw APIError("HTTPError \(httpResponse.statusCode)") }
            
            let decoder = JSONDecoder()
            let albumTracksRP = try decoder.decode(ListRP<Track>.self, from: data)
            print(albumTracksRP.total)
            return albumTracksRP
        } catch {
            print(error)
            throw APIError(error.localizedDescription)
        }
    }

    func getCatagories() async throws -> CategoriesRP {
        guard let url = URL(string: "https://api.spotify.com/v1/browse/categories?country=CA") else { throw APIError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if authToken == nil { await getToken() }
        
        request.addValue("Bearer \(authToken!.access_token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw APIError("HTTP Error") }
            if !(200...299).contains(httpResponse.statusCode) { throw APIError("HTTPError \(httpResponse.statusCode)") }
            
            let decoder = JSONDecoder()
            let categoriesRp = try decoder.decode(CategoriesRP.self, from: data)
            print(categoriesRp.categories.total)
            return categoriesRp
        } catch {
            throw APIError(error.localizedDescription)
        }
    }
    
    func getPlaylistsByCategory(categoryId: String) async throws -> PlaylistRP {
        guard let url = URL(string: "https://api.spotify.com/v1/browse/categories/\(categoryId)/playlists") else { throw APIError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if authToken == nil { await getToken() }
        
        request.addValue("Bearer \(authToken!.access_token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw APIError("HTTP Error") }
            if !(200...299).contains(httpResponse.statusCode) { throw APIError("HTTPError \(httpResponse.statusCode)") }
            
            let decoder = JSONDecoder()
            let playlistRP = try decoder.decode(PlaylistRP.self, from: data)
            print(playlistRP.playlists.total)
            return playlistRP
        } catch {
            print(error)
            throw APIError(error.localizedDescription)
        }
    }
    
    func getPlaylistsTracks(url: String) async throws -> ListRP<PlaylistTracks> {
        guard let url = URL(string: url) else { throw APIError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if authToken == nil { await getToken() }
        
        request.addValue("Bearer \(authToken!.access_token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw APIError("HTTP Error") }
            if !(200...299).contains(httpResponse.statusCode) { throw APIError("HTTPError \(httpResponse.statusCode)") }
            
            let decoder = JSONDecoder()
            let tracksRP = try decoder.decode(ListRP<PlaylistTracks>.self, from: data)
            print(tracksRP.total)
            return tracksRP
        } catch {
            print(error)
            throw APIError(error.localizedDescription)
        }
    }
    
}
