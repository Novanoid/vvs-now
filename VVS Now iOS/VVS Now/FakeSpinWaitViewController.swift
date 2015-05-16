//
//  FakeSpinWaitViewController.swift
//  VVS Now
//
//  Created by Frederik Riedel on 16.05.15.
//  Copyright (c) 2015 Frederik Riedel. All rights reserved.
//

import UIKit

class FakeSpinWaitViewController: UIViewController {

    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden=true
        
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.lightGrayColor()
        
        var activityindicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.view.addSubview(activityindicator)
        
        activityindicator.startAnimating()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.navigationController?.popViewControllerAnimated(true)
            self.navigationController?.navigationBarHidden=false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
