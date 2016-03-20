//
//  PhotosCell.swift
//  test
//
//  Created by sarav on 16/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    var frontView: SPImageView?
    var backView: UIView?
    var isFrontVisible: Bool = true

    var photoObj: FlickrPhoto?
    
    required internal init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override internal init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit()
    {
        frontView = SPImageView(frame: self.bounds)
        frontView?.contentMode = UIViewContentMode.ScaleAspectFit
        frontView?.clipsToBounds = true
        self.addSubview(frontView!)

        self.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        
        let singleTap = UITapGestureRecognizer(target: self, action: "tapped")
        self.addGestureRecognizer(singleTap)
    }
    
    func updateData()
    {
        updateDataForFront()
    }
    
    private func updateDataForFront()
    {
        frontView?.setImageFromUrl(photoObj!.getImageURL(), cachingKey: photoObj!.photoID!)
    }
    
    private func updateDataForBack()
    {
        (backView?.viewWithTag(500) as? UILabel)?.text = photoObj!.title
    }
    
    func tapped()
    {
        if(isFrontVisible)
        {
            isFrontVisible = false
            flipToBack()
        }
        else
        {
            isFrontVisible = true
            flipToFront()
        }
    }
    
    private func addBackView()
    {
        backView = UIView(frame: self.bounds)
        backView?.backgroundColor = UIColor.whiteColor()

        let label = UILabel(frame: backView!.bounds)
        label.tag = 500
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        label.font = Fonts.IMAGE_BACK_TITLE
        backView?.addSubview(label)
        
        self.addSubview(backView!)
    }
    
    private func flipToBack()
    {
        if(backView == nil)
        {
            addBackView()
            updateDataForBack()
        }
        
        UIView.transitionFromView(frontView!, toView: backView!, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft) { (flag) -> Void in
            
        }
    }
    
    private func flipToFront()
    {
        UIView.transitionFromView(backView!, toView: frontView!, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight) { (flag) -> Void in
            
        }
    }
}
