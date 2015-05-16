//
//  ViewController.swift
//  VVS Now
//
//  Created by Frederik Riedel on 16.05.15.
//  Copyright (c) 2015 Frederik Riedel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SearchViewControllerDelegate {

    var selectTarget : UIButton?
    var selectedStop : Haltestelle!
    var datePicker : UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title="VVS Now"
        
        self.view.backgroundColor=UIColor.lightGrayColor()
        
        var routenButton = UIBarButtonItem(title: "Meine Ziele", style: UIBarButtonItemStyle.Plain, target: self, action: "routen")
        self.navigationItem.rightBarButtonItem=routenButton
        
        selectTarget = UIButton(frame: CGRectMake(44, 88, self.view.frame.width-88, 44))
        selectTarget!.setTitle("Ziel auswählen…", forState: UIControlState.Normal)
        selectTarget!.addTarget(self, action: "showSearchVIewController", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(selectTarget!)
        
        
        datePicker = UIDatePicker(frame: CGRectMake(0, self.view.frame.height-216.0-200, self.view.frame.width, 216.0))
        
        datePicker?.setValue(UIColor.whiteColor(), forKey: "textColor")
        
        self.view.addSubview(datePicker!)
        
        var ankuftszeitlabel = UILabel(frame: CGRectMake(0, datePicker!.frame.origin.y-44, self.view.frame.width, 44))
        ankuftszeitlabel.text="Ankunftszeit:"
        ankuftszeitlabel.textAlignment=NSTextAlignment.Center
        ankuftszeitlabel.textColor=UIColor.whiteColor()
        ankuftszeitlabel.font=UIFont(name: "Helveticaneue-light", size: 24)
        self.view.addSubview(ankuftszeitlabel)
        
        
        var zackfertig = UIButton(frame: CGRectMake(50, datePicker!.frame.origin.y + datePicker!.frame.height + 100, self.view.frame.width-100, 44))
        zackfertig.backgroundColor=UIColor.orangeColor()
        zackfertig.setTitle("Ziel hinzufügen", forState: UIControlState.Normal)
        zackfertig.addTarget(self, action: "zackfertig", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(zackfertig)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func zackfertig() {
        var fakeSpinViewController = FakeSpinWaitViewController()
        self.navigationController?.pushViewController(fakeSpinViewController, animated: true)
        AppDelegate.meineZiele.addObject("\(selectTarget!.titleLabel!.text!)")
        
        var query : String = "\(AppDelegate.baseURL)/tasks/1/\(selectedStop?.id!)/\(datePicker?.date.timeIntervalSince1970)"

        query = query.stringByReplacingOccurrencesOfString("Optional(", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        query = query.stringByReplacingOccurrencesOfString(")", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        println(query)
        
       
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: query)!) { data, response, error in
            
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            
            }.resume()
    }
    
    func showSearchVIewController() {
        var searchViewController = SearchViewController()
        searchViewController.delegate😀=self
        var searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        self.navigationController?.presentViewController(searchNavigationController, animated: true, completion: nil)
    }
    
    func selectHaltestelle(haltestelle: Haltestelle) {
        selectedStop = haltestelle
        selectTarget!.setTitle("\(haltestelle.name!)", forState: UIControlState.Normal)
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

