//
//  FlickrPhoto.swift
//  test
//
//  Created by sarav on 17/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class FlickrPhoto: NSObject {

    var photoID: String?
    var secret: String?
    var farm: String?
    var server: String?
    var size: String?
    var title: String?
    
    
    func getImageURL() -> NSURL!
    {
        let url = NSURL(string:"https://farm\(farm!).staticflickr.com/\(server!)/\(photoID!)_\(secret!)_\(size!).jpg")
        return url
    }
}
