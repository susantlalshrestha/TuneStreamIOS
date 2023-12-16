//
//  UIArtistTableViewCell.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import UIKit

class UIArtistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbArtistName: UILabel!
    @IBOutlet weak var imvArtist: UIImageView!
    
    func loadImage(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {self?.imvArtist.image = image}
            }
        }.resume()
    }
}
