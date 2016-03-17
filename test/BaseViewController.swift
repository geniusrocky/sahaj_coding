//
//  BaseViewController.swift
//  test
//
//  Created by sarav on 17/03/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var activity: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityView()
    }

    func initActivityView()
    {
        activity = UIActivityIndicatorView(frame: CGRectMake((self.view.frame.size.width-50/2), (self.view.frame.size.height-50/2), 50, 50))
        activity!.translatesAutoresizingMaskIntoConstraints = false
        activity!.layer.cornerRadius = 5
        activity!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activity!.backgroundColor = UIColor.darkGrayColor()
    }

    func showLoadingIndicator()
    {
        let currentWindow : UIWindow = UIApplication.sharedApplication().keyWindow!
        let height : CGFloat = UIScreen.mainScreen().bounds.size.height
        let width : CGFloat = UIScreen.mainScreen().bounds.size.width
        let center : CGPoint = CGPointMake(width / 2.0, height / 2.0)
        activity!.center = center
        currentWindow.addSubview(activity!)

        activity!.startAnimating()
    }
    
    func hideLoadingIndiactor()
    {
        activity!.removeFromSuperview()
    }

    

}
