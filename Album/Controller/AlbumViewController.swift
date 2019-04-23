//
//  AlbumViewController.swift
//  Album
//
//  Created by Vinitha Vijayan on 4/22/19.
//  Copyright © 2019 Vinitha Vijayan. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var albumImageView: CustomImageView!
    
    var album = Album()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perepareUI()
    }
    
    // MARK: - Private Methods
    
    private func perepareUI() {
        navigationItem.title = album.name
        self.artistNameLabel.text = album.artistName
        
        if let genre = album.genre {
            let ids: [String] = genre.map { if let genreName = $0.name {
                return genreName
                }
                
                return ""
            }
            self.genreLabel.text = ids.joined(separator:", ")
        }
        
        if let releaseDate = album.releaseDate {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd, yyyy"
            
            if let date = dateFormatterGet.date(from: releaseDate) {
                var releaseDateInfo = ""
                if date < Date() {
                    releaseDateInfo = "Released "
                } else {
                    releaseDateInfo = "Expected "
                }
                
                releaseDateLabel.text = releaseDateInfo + dateFormatterPrint.string(from: date)
            }
        }
        
        copyrightLabel.text = album.copyright
        
        if let url = album.artworkUrl100 {
            albumImageView.loadImageViewWithUrl(urlString: url)
        }
        
    }
    
    // MARK: - Action Methods
    
    @IBAction func listenMusicButtonTapped(_ sender: Any) {
        if let albumUrl = album.url {
            if let encodedUrl = albumUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let url  = URL(string: encodedUrl)
                if UIApplication.shared.canOpenURL(url! as URL) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
