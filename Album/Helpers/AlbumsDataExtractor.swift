//
//  AlbumsDataExtractor.swift
//  Album
//
//  Created by Vinitha Vijayan on 4/22/19.
//  Copyright © 2019 Vinitha Vijayan. All rights reserved.
//

import UIKit

class AlbumsDataExtractor {
    
    func extractAlbumData(response: [String : AnyObject]) -> [Album] {
        var albums = [Album]()
        
        if let feed =  response["feed"] as? [String : AnyObject] {
            let albumsDict = SharedValueExtractor.arrayOfDictionaryValue(feed, forKey: "results")
            
            for albumDict in albumsDict {
                let album = Album(dictionary: albumDict)
                albums.append(album)
            }
        }
        
        return albums
    }
}
