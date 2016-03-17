//
//  Constants.swift
//  test
//
//  Created by sarav on 17/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

struct API_KEYS {
    static let FLICKR = "36a7946ebf0592370d3c179a81c7f57f"
}


struct URLS
{
    static let FLICKR_GET_PHOTOS = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(API_KEYS.FLICKR)&text=\(STRINGS.SEARCH_TEXT)&per_page=50&page=1&format=json&nojsoncallback=1"
}

struct Fonts
{
    static let NAV_TITLE = UIFont(name: "Helvetica", size: 15.0)!
    static let IMAGE_BACK_TITLE = UIFont(name: "Helvetica", size: 10.0)!
}

struct STRINGS
{
    static let SEARCH_TEXT = "volkswagen"
}