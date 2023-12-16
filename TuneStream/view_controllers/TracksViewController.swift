//
//  TracksViewController.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import UIKit

class TracksViewController: UIBaseViewController, UITableViewDelegate, UITableViewDataSource, GetAlbumTracksDelegate {
    
    var album: Album?
    
    private var tracks = Array<Track>()
    private var artistsVM : ArtistsVM?
    
    @IBOutlet weak var tvTracks: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "Track# \(track.track_number) : \(track.name)"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if album == nil {self.dismiss(animated: true)}
        
        self.artistsVM = (UIApplication.shared.delegate as! AppDelegate).artistsVM
        
        tvTracks.delegate = self
        tvTracks.dataSource = self
        
        navItem.title = album!.name
        
        self.artistsVM?.getAlbumTracksDelegate = self
        self.artistsVM?.getAlbumTracks(albumID: self.album!.id)
    }
    
    func onGetAlbumTracksSuccess(tracks: [Track]) {
        self.tracks = tracks
        self.tvTracks.reloadData()
    }
    
    func onGetAlbumTracksFailed(error: String) {
        self.showError(message: error)
    }
}
