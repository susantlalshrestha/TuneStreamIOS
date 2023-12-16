//
//  ArtistViewController.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import UIKit

class ArtistViewController: UIBaseViewController, UITableViewDelegate, UITableViewDataSource, GetArtistAlbumsDelegate {
    
    var artist: Artist?

    private var selectedAlbum : Album?
    private var albums = Array<Album>()
    private var artistsVM : ArtistsVM?

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var imvArtistImage: UIImageView!
    @IBOutlet weak var tvAlbums: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvAlbums.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! UIAlbumTableViewCell
        let album = albums[indexPath.row]
        cell.lbAlbumName.text = album.name
        cell.lbTotalTracks.text = "\(album.total_tracks) Tracks"
        if let imageUrl = album.images.first?.url {
            cell.loadImage(url: imageUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAlbum = albums[indexPath.row]
        performSegue(withIdentifier: "seg_tracks", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg_tracks" {
            if let destinationVC = segue.destination as? TracksViewController {
                destinationVC.album = self.selectedAlbum
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if artist == nil {self.dismiss(animated: true)}
        
        self.artistsVM = (UIApplication.shared.delegate as! AppDelegate).artistsVM
        
        tvAlbums.delegate = self
        tvAlbums.dataSource = self
        
        navItem.title = artist!.name
        if let imageUrl = artist?.images?.first?.url { loadImage(url: imageUrl) }
        
        self.artistsVM?.getArtistAlbumsDelegate = self
        self.artistsVM?.getArtistAlbums(artistID: self.artist!.id)
    }
    
    func loadImage(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {self?.imvArtistImage.image = image}
            }
        }.resume()
    }
    
    func onGetArtistAlbumsSuccess(albums: [Album]) {
        self.albums = albums
        self.tvAlbums.reloadData()
    }
    
    func onGetArtistAlbumsFailed(error: String) {
        showError(message: error)
    }
}
