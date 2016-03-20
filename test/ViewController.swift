//
//  ViewController.swift
//  test
//
//  Created by sarav on 16/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var photosList:[FlickrPhoto]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubViews()
        loadPhotos()
    }
    
    func initSubViews()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.registerClass(PhotosCell.self, forCellWithReuseIdentifier: "photosCell")
        self.view.addSubview(collectionView)
    }
    
    func loadPhotos(){
        showLoadingIndicator()
        
        NetworkHelper().getPhotos({ (data) -> Void in
            self.photosList = data
            self.performSelectorOnMainThread("reloadData", withObject: nil, waitUntilDone: false)
            }) { (error) -> Void in
                self.performSelectorOnMainThread("showError:", withObject: error!, waitUntilDone: false)
        }
    }
    
    func reloadData()
    {
        hideLoadingIndiactor()
        self.collectionView.reloadData()
    }
    
    func showError(string: String)
    {
        print(string)
        hideLoadingIndiactor()
        showErrorMsg(string)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cnt = photosList?.count else {
            return 0
        }
        return cnt
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photosCell", forIndexPath: indexPath) as! PhotosCell
        cell.photoObj = photosList![indexPath.item]
        cell.updateData()
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let wdth = (collectionView.bounds.size.width/2) - 1
        return CGSizeMake(wdth, 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 2
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0,0,0,0)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 2
    }
}