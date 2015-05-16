//
//  ViewController.swift
//  VVS Now
//
//  Created by Frederik Riedel on 16.05.15.
//  Copyright (c) 2015 Frederik Riedel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="VVS Now"
        
        self.view.backgroundColor=UIColor.lightGrayColor()
        
        var routenButton = UIBarButtonItem(title: "Meine Routen", style: UIBarButtonItemStyle.Plain, target: self, action: "routen")
        self.navigationItem.rightBarButtonItem=routenButton
        
        var selectTarget = UIButton(frame: CGRectMake(44, 88, self.view.frame.width-88, 44))
        selectTarget.setTitle("Ziel auswählen…", forState: UIControlState.Normal)
        selectTarget.addTarget(self, action: "showSearchVIewController", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(selectTarget)
        
        
        var datePicker = UIDatePicker(frame: CGRectMake(0, self.view.frame.height-216.0, self.view.frame.width, 216.0))
        self.view.addSubview(datePicker)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showSearchVIewController() {
        var searchViewController = SearchViewController()
        var searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        self.navigationController?.presentViewController(searchNavigationController, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func routen() {
        var meineRoutenViewController = MeineRoutenViewController()
        self.navigationController?.pushViewController(meineRoutenViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

