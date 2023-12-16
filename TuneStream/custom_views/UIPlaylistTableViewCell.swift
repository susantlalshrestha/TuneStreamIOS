//
//  UIPlaylistTableViewCell.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/15/23.
//

import UIKit

class UIPlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var imvPlaylist: UIImageView!
    @IBOutlet weak var lbOwner: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTotalTrack: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadImage(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {self?.imvPlaylist.image = image}
            }
        }.resume()
    }
}
