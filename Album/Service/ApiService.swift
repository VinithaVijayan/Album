//
//  ApiService.swift
//  Album
//
//  Created by Vinitha Vijayan on 4/22/19.
//  Copyright © 2019 Vinitha Vijayan. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    func fetchAlbumsFor(completion: @escaping (_ albumbs: [Album]?, _ error: Error?) -> ()) {
        let url = URL(string: kBaseurl)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let err = error {
                completion(nil, err)
            } else {
                do {
                    if let unwrappedData = data, let jsonDicts = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String: AnyObject] {
                        let albums = AlbumsDataExtractor().extractAlbumData(response: jsonDicts)
                        DispatchQueue.main.async {
                            completion(albums, nil)
                        }
                    }
                } catch _ {
                    print("error")
                }            }
            }.resume()
    }
}

