//
//  testTests.swift
//  testTests
//
//  Created by sarav on 16/03/16.
//  Copyright © 2016. All rights reserved.
//

import XCTest
@testable import test

class testTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testInitSubViews()
    {
        XCTAssertEqual(viewController.collectionView, nil, "collectionview is not created")
    }
    
    func testItemCount()
    {
        viewController.initSubViews()
        let cnt = viewController.collectionView.numberOfItemsInSection(0)
        XCTAssertEqual(cnt, 0, "working")
    }
    
    func testImageRetreivalFromCache()
    {
        let img = SPImageCache.sharedInstance.imageForKey("test")
        XCTAssertNil(img)
        
        SPImageCache.sharedInstance.storeImage(UIImage(named: "failed")!, forKey: "test")
        let img1 = SPImageCache.sharedInstance.imageForKey("test")
        XCTAssertNotNil(img1)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
}
