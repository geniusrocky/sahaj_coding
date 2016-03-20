//
//  SPCache.swift
//  test
//
//  Created by sarav on 16/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class SPImageCache {
    
    class var sharedInstance: SPImageCache {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: SPImageCache? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = SPImageCache()
            
            let path = Static.instance?.cacheDirectoryPath()
            Static.instance?.checkAndCreateCacheDirectory(path as! String)
        }
        return Static.instance!
    }
    
    private var memCache:[String: UIImage] = [String: UIImage]()
    
    func resetCache()
    {
        clearMemCache()
        clearDisk()
    }
    
    func clearMemCache()
    {
        self.memCache.removeAll()
    }
    func clearDisk()
    {
        do{
            let path = cacheDirectoryPath() as! String
            try NSFileManager.defaultManager().removeItemAtPath(path)
            checkAndCreateCacheDirectory(path)
        }catch{
        }
    }
    
    func imageForKey(key: String) -> UIImage?
    {
        if let v = self.memCache[key]{
            return v
        }
        else{
            let filePath = cacheDirectoryPath().stringByAppendingPathComponent(key)
            if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
                return UIImage(contentsOfFile: filePath)
            }
            return nil
        }
    }
    
    func storeImage(img: UIImage, forKey: String)
    {
        storeImage(img, forKey: forKey, toDisk: false)
    }
    
    func storeImage(img: UIImage, forKey: String, toDisk: Bool)
    {
        self.memCache[forKey] = img
        
        if(toDisk)
        {
            let filePath = cacheDirectoryPath().stringByAppendingPathComponent(forKey)
            if let pngData = UIImagePNGRepresentation(img)
            {
                pngData.writeToFile(filePath, atomically: true)
            }
        }
    }
    
    func cacheDirectoryPath() -> AnyObject
    {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory: AnyObject = paths[0]
        let dataPath = documentsDirectory.stringByAppendingPathComponent("spimagecache")
     
        return dataPath
    }
    
    func checkAndCreateCacheDirectory(dataPath: String) -> Bool
    {
        var isDirectory: ObjCBool = false
        if NSFileManager.defaultManager().fileExistsAtPath(dataPath, isDirectory: &isDirectory) {
            if(isDirectory)
            {
                return true
            }
        }
        else
        {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil)
                return true
            } catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        return false
    }
}

