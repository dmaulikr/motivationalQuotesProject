//
//  AppDelegate.swift
//  kept
//
//  Created by AnthonyAu on 12/2/15.
//  Copyright © 2015 anthonyau. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()!
        if settings.types.isEmpty {
            self.registerNewNotification()
        }
        
        self.setUpNotification()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.archiveQuotes()
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
    
    //    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    //        print(notification.alertTitle)
    //        print(notification.alertBody)
    //    }
    
    private func archiveQuotes() {
        let success = quoteStore.sharedInstance.saveQuotes()
        if !success {
            print("save failed")
        }
    }
    
    func registerNewNotification() {
        let alertType = UIUserNotificationType.Alert
        let badgeType = UIUserNotificationType.Badge
        let types: UIUserNotificationType = [alertType, badgeType]
        let mySettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
    }
    
    func setUpNotification() {
        let notificationType = UILocalNotification()
        
        //set a new notification at 10AM the next day whenever you open the app - how you can repeat it every day? maybe remote notifications
        let futureDate = NSDate(timeIntervalSinceNow: 60.0 * 60.0 * 12.0)
        notificationType.fireDate = futureDate
        notificationType.timeZone = NSTimeZone.defaultTimeZone()
        
        if let quote = quoteStore.sharedInstance.returnRandomQuote() {
            notificationType.alertBody = quote.quoteText
            notificationType.alertTitle = quote.author
        } else {
            notificationType.alertBody = "Add quotes!"
            notificationType.alertTitle = "No quotes yet!"
        }
        
        UIApplication.sharedApplication().scheduleLocalNotification(notificationType)
    }
    
    
}

