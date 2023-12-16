//
//  UIAlbumTableViewCell.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import UIKit

class UIAlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imvAlbum: UIImageView!
    @IBOutlet weak var lbAlbumName: UILabel!
    @IBOutlet weak var lbTotalTracks: UILabel!
    
    func loadImage(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {self?.imvAlbum.image = image}
            }
        }.resume()
    }
}
