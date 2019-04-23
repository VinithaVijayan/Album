//
//  ViewController.swift
//  Album
//
//  Created by Vinitha Vijayan on 4/22/19.
//  Copyright © 2019 Vinitha Vijayan. All rights reserved.
//

import UIKit

class AlbumListViewController: UITableViewController {
    var albums = [Album]()
    var selectedAlbum: Album?
    let kAlbumTableViewCellID = "AlbumTableViewCellID"
    let kAlbumTableViewCellName = "AlbumTableViewCell"
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: self.view.frame.width - 20, height: 20)
        label.center = self.view.center
        label.isHidden = true
        return label
    }()
    
    lazy var activitiIndicator: UIActivityIndicatorView = {
        let activitiIndicator = UIActivityIndicatorView(style: .gray)
        activitiIndicator.hidesWhenStopped = true
        activitiIndicator.center = CGPoint(x: self.view.frame.size.width / 2.0, y: self.view.frame.size.height / 2.0)
        activitiIndicator.startAnimating()
        return activitiIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareAlbumUI()
        getAlbumData()
    }
    
    
    // MARK: - TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: kAlbumTableViewCellID, for: indexPath) as! AlbumTableViewCell
        cell.album = albums[indexPath.row]
        return cell
    }
    
    // MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let album = albums[indexPath.row]
        var height: CGFloat = 100
        
        if let nameLabelHeight = album.name?.height(withConstrainedWidth: tableView.frame.width - 110, font: UIFont.systemFont(ofSize: 15, weight: .light)) {
            height = nameLabelHeight + 85 > height ?  nameLabelHeight + 85 : height
        }
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAlbum = albums[indexPath.row]
        performSegue(withIdentifier: kAlbumViewControllerSegueID, sender: nil)
    }
    
    // MARK: - Private Methods
    
    private func prepareAlbumUI() {
        navigationItem.title = kAppTitle
        
        tableView.register(UINib(nibName: kAlbumTableViewCellName, bundle: nil), forCellReuseIdentifier: kAlbumTableViewCellID)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(activitiIndicator)
        view.addSubview(errorLabel)
    }
    
    private func getAlbumData() {
        ApiService.sharedInstance.fetchAlbumsFor { (albums, error) in
            self.activitiIndicator.stopAnimating()
            
            if let _ = error {
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Unable to show album"
            } else if let albumsData = albums, albumsData.count > 0  {
                self.albums = albumsData
                self.tableView.isHidden = false
                self.tableView.reloadData()
            } else {
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Unable to show album"
            }
        }
    }
    
    //MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kAlbumViewControllerSegueID {
            if let album = selectedAlbum {
                let controller = segue.destination as! AlbumViewController
                controller.album = album
            }
        }
    }
}

