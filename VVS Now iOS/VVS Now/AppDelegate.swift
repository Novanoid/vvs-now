//
//  AppDelegate.swift
//  VVS Now
//
//  Created by Frederik Riedel on 16.05.15.
//  Copyright (c) 2015 Frederik Riedel. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    static var uuid : NSString?
    let locationManager = CLLocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {


        
        
        UINavigationBar.appearance().barTintColor=UIColor(red: 1.0, green: 102/255.0, blue: 0.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor=UIColor.whiteColor()

        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        
        
        locationManager.distanceFilter = 40
        locationManager.delegate=self
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()
        
        let rootViewController = UINavigationController(rootViewController: ViewController())
        
        
        
        self.window?.rootViewController=rootViewController
        
        
        
        
//        UIApplication.sharedApplication().statusBarHidden = true
        

        var types = UIUserNotificationType.Badge | UIUserNotificationType.Sound | UIUserNotificationType.Alert
        var settings: UIUserNotificationSettings = UIUserNotificationSettings( forTypes: types, categories: nil )
        
        application.registerUserNotificationSettings( settings )

        
//        UIUserNotificationSettings *mySettings =
  //          [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
        application.registerForRemoteNotifications()

        
        
        // Override point for customization after application launch
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("handleTimer:"), userInfo: nil, repeats: true)

        
        return true
    }
    
    
    func application( application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData ) {

        var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        var deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        
        AppDelegate.uuid = deviceTokenString
        
        println( deviceTokenString )
        
    }
    
    func application( application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError ) {
        
        println( error.localizedDescription )
    }
    
    func handleTimer(timer: NSTimer) {

        //locationManager.startUpdatingLocation()
        
        var loc: CLLocationManager?
        loc = CLLocationManager()
        //loc?.delegate=self
        
        loc?.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        
        println(coord.latitude)
        println(coord.longitude)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        println("Push nachricht empfangen")
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

