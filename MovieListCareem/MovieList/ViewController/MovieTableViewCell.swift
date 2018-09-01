//
//  MovieTableViewCell.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 9/1/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit
import Kingfisher
class MovieTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Configure cell with Movie item
    func configure(movie:Movie)  {
        self.nameLabel.text = movie.name
        self.releaseDateLabel.text = movie.releaseDate
        self.overviewLabel.text = movie.overview
     
        if movie.posterUrl != nil , let url = URL(string:"\(NetworkManager.baseImageURL)\(movie.posterUrl!)") {
            self.posterImageView.kf.setImage(with: url)
        }else
        {
             self.posterImageView.image = UIImage(named: "MoviePlaceholder")
        }
    }

}
