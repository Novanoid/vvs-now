//
//  SearchViewController.swift
//  VVS Now
//
//  Created by Frederik Riedel on 16.05.15.
//  Copyright (c) 2015 Frederik Riedel. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate {
    func selectHaltestelle(haltestelle : Haltestelle)
}

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var haltestellen = NSMutableArray()
    var suchergebnis = NSMutableArray()
    var searchTable : UITableView?
    var delegate😀 : SearchViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.lightGrayColor()
        
        
        
        
        var cancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        self.navigationItem.rightBarButtonItem=cancel
        
        var searchBar = UISearchBar(frame: CGRectMake(0, 64, self.view.frame.width, 44))
        self.view.addSubview(searchBar)
        searchBar.delegate=self
        searchBar.barTintColor=UINavigationBar.appearance().barTintColor
        
        var path = NSBundle.mainBundle().pathForResource("fake_ludwigstraße", ofType: "csv")
        
        var rawfakeData = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
        
        let rawhaltestellen : [String] = rawfakeData!.componentsSeparatedByString("\n")
        
        
        
        for haltestellenString in rawhaltestellen {
            var haltestelle = Haltestelle()
            haltestelle.name = haltestellenString.componentsSeparatedByString(";")[0]
            haltestelle.ort = haltestellenString.componentsSeparatedByString(";")[1]
            haltestelle.id = haltestellenString.componentsSeparatedByString(";")[2]
            println(haltestelle.name)
            haltestellen.addObject(haltestelle)
        }
        
        
        searchTable = UITableView(frame: CGRectMake(0, 64+44, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Plain)
        self.view.addSubview(searchTable!)
        searchTable?.delegate=self
        searchTable?.dataSource=self
        
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        var haltestelle : Haltestelle = suchergebnis[indexPath.row] as! Haltestelle
        
        cell.textLabel?.text = haltestelle.name! as String
        cell.detailTextLabel?.text = haltestelle.ort! as String
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suchergebnis.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var haltestelle : Haltestelle = suchergebnis[indexPath.row] as! Haltestelle
        delegate😀?.selectHaltestelle(haltestelle)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        suchergebnis.removeAllObjects()
        
        for haltestelle in haltestellen {
            if haltestelle.name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                suchergebnis.addObject(haltestelle)
            }
        }
        searchTable!.reloadData()
        
    }
    
    
    
    func done() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
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
