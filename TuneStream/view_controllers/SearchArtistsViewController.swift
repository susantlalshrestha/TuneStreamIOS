//
//  SearchArtistsViewController.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import UIKit

class SearchArtistsViewController: UIBaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SearchArtistsDelegate {
    
    private var artistsVM : ArtistsVM?
    private var artists = Array<Artist>()
    private var selectedArtist : Artist?
    
    @IBOutlet weak var tvSearchList: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvSearchList.dequeueReusableCell(withIdentifier: "ArtistsCell", for: indexPath) as! UIArtistTableViewCell
        
        let artist = artists[indexPath.row]
        cell.lbArtistName.text = artist.name
        if let imageUrl = artist.images?.first?.url {
            cell.loadImage(url: imageUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedArtist = artists[indexPath.row]
        performSegue(withIdentifier: "seq_artist", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count <= 2){
            artists = [Artist]()
            tvSearchList.reloadData()
            return
        }
        self.artistsVM!.searchArtists(searchText)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seq_artist" {
            if let destinationVC = segue.destination as? ArtistViewController {
                destinationVC.artist = self.selectedArtist
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artistsVM = (UIApplication.shared.delegate as! AppDelegate).artistsVM
        
        tvSearchList.delegate = self;
        tvSearchList.dataSource = self;
        
        self.artistsVM?.searchArtistsDelegate = self
    }
    
    func onSearchArtitsSuccess(artists: [Artist]) {
        self.artists = artists
        self.tvSearchList.reloadData()
    }
    
    func onSearchArtitsFailed(error: String) {
        showError(message: error)
    }
}
