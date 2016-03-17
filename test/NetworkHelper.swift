//
//  NetworkHelper.swift
//  test
//
//  Created by sarav on 17/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class NetworkHelper: NSObject {

    func getPhotos(onSuccess:([FlickrPhoto]?)-> Void, onFailure:(String?)-> Void)
    {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: URLS.FLICKR_GET_PHOTOS)!)
        urlRequest.HTTPMethod = "GET"

        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data, resposne, error) -> Void in

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
                        photoObj.size = "q"
                        
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
                onFailure("")
                print("error parsing data")
            }
        }
        task.resume()
        
    }
    
}
