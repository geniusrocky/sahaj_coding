//
//  NetworkHelper.swift
//  test
//
//  Created by sarav on 17/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

typealias SuccessHandler = ([FlickrPhoto]?) -> Void
typealias FailureHandler = (String?) -> Void


class NetworkHelper: NSObject {
    
    
    func getPhotos(onSuccess:SuccessHandler, onFailure:FailureHandler)
    {
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: URLS.FLICKR_GET_PHOTOS)!)
        urlRequest.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data, resposne, error) -> Void in
            
            if(error == nil)
            {
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    
                    if((dic["stat"] as! String) == "ok")
                    {
                        let photosArr = dic["photos"]!!["photo"] as! [[String:AnyObject]]
                        
                        var flickrPhotoObjects = [FlickrPhoto]()
                        
                        for photo in photosArr
                        {
                            let photoObj = FlickrPhoto()
                            photoObj.farm = "\(photo["farm"]!)"
                            photoObj.secret = "\(photo["secret"]!)"
                            photoObj.photoID = "\(photo["id"]!)"
                            photoObj.server = "\(photo["server"]!)"
                            photoObj.title = "\(photo["title"]!)"
                            photoObj.size = "n"
                            
                            flickrPhotoObjects.append(photoObj)
                        }
                        
                        onSuccess(flickrPhotoObjects)
                    }
                    else
                    {
                        onFailure(dic["message"] as? String)
                    }
                }
                catch{
                    onFailure("error parsing data")
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
        task.resume()
        
    }
    
}
