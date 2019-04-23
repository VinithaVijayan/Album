//
//  Album.swift
//  Album
//
//  Created by Vinitha Vijayan on 4/22/19.
//  Copyright © 2019 Vinitha Vijayan. All rights reserved.
//

import Foundation

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let upperCasedFirstChar = String(key.first!).uppercased()
        let range = key.startIndex...key.index(key.startIndex, offsetBy: 0)
        let selectorString = key.replacingCharacters(in: range, with: upperCasedFirstChar)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

class Album: SafeJsonObject {
    @objc var name: String?
    @objc var artistName: String?
    @objc var artworkUrl100: String?
    @objc var releaseDate: String?
    @objc var copyright: String?
    @objc var url: String?
    @objc var genre: [Genre]?
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "genres" {
            if let genresArray = value as? [[String: AnyObject]] {
                self.genre = [Genre]()
                for genreDict in genresArray {
                    let genre = Genre(dictionary: genreDict)
                    self.genre?.append(genre)
                }
                
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
}


class Genre: NSObject {
    @objc var name: String?
    @objc var url: String?
    @objc var genreId: String?
    
    init(dictionary: [String: Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
}
