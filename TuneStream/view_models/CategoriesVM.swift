//
//  CategoriesVM.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import Foundation

protocol CategoriesVMDelegate {
    func onGetCategoriesSuccess(categories: [Category])
    func onGetCategoriesFailed(error: String)
}

class CategoriesVM {
    
    private let spotifyApi: SpotifyApi
    var delegate: CategoriesVMDelegate?
    
    init(spotifyApi: SpotifyApi) {
        self.spotifyApi = spotifyApi
    }
    
    func getCategories() {
        Task.init {
            do {
                let categoriesRP = try await spotifyApi.getCatagories()
                DispatchQueue.main.async {
                    self.delegate?.onGetCategoriesSuccess(categories: categoriesRP.categories.items)
                }
            } catch let error as APIError {
                DispatchQueue.main.async {
                    self.delegate?.onGetCategoriesFailed(error: error.message)
                }
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.onGetCategoriesFailed(error: error.localizedDescription)
                }
            }
        }
    }
}
