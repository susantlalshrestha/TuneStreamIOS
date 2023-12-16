//
//  PlaylistsViewController.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import UIKit

class PlaylistsViewController: UIBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var playlistsVM : PlaylistsVM?
    
    private var playlists = Array<Playlist>()
    
    var category: Category?
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tvPlaylists: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPlaylists.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as! UIPlaylistTableViewCell
        
        let playlist = playlists[indexPath.row]
        cell.lbTitle.text = playlist.name
        cell.lbOwner.text = playlist.owner.display_name
        cell.lbTotalTrack.text = "Total tracks: \(playlist.tracks.total)"
        if let imageUrl = playlist.images.first?.url {
            cell.loadImage(url: imageUrl)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playlistsVM = (UIApplication.shared.delegate as! AppDelegate).playlistsVM
        
        if category == nil {self.dismiss(animated: true)}
        
        navItem.title = "\(category!.name) Playlists"
        
        tvPlaylists.dataSource = self
        tvPlaylists.delegate = self
        
        Task.init {
            let (playlists, error) = await self.playlistsVM!.getPlaylistsByCategory(categoryId: self.category!.id)
            DispatchQueue.main.async {
                self.playlists = playlists
                self.tvPlaylists.reloadData()
                if let error = error { self.showError(message: error) }
            }
        }
    }
}
