//
//  AlbumTableViewCell.swift
//  Album
//
//  Created by Vinitha Vijayan on 4/22/19.
//  Copyright © 2019 Vinitha Vijayan. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: CustomImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    var album: Album? {
        didSet {
            albumTitleLabel.text = album?.name
            artistNameLabel.text = album?.artistName
            setupThumbnial()
        }
    }
    
    func setupThumbnial() {
        if let url = album?.artworkUrl100 {
            thumbnailImageView.loadImageViewWithUrl(urlString: url)
        }
    }
}
