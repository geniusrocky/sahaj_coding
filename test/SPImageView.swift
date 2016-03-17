//
//  SPImageView.swift
//  test
//
//  Created by sarav on 17/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class SPImageView : UIImageView {

    private var associatedObjId: String?
    
    func setImageFromUrl(url: NSURL, cachingKey: String)
    {
        setImageFromUrl(url, cachingKey: cachingKey, saveToDisk: false)
    }
    
    func setImageFromUrl(url: NSURL, cachingKey: String, saveToDisk: Bool)
    {
        let img = SPImageCache.sharedInstance.imageForKey(cachingKey)
        if(img == nil)
        {
            self.image = UIImage(named: "placeholder")
            associatedObjId = cachingKey
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                let data = NSData(contentsOfURL: url)
                let img = UIImage(data: data!)
                SPImageCache.sharedInstance.storeImage(img!, forKey: cachingKey, toDisk: saveToDisk)

                if(self.associatedObjId == cachingKey)
                {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.image = img
                    })
                }
            })
        }
        else
        {
            self.image = img
        }
    }

}
