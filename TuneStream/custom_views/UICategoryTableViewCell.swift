//
//  UIArtistTableViewCell.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import UIKit

class UICategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var imvImage: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    
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
                DispatchQueue.main.async {self?.imvImage.image = image}
            }
        }.resume()
    }
}
