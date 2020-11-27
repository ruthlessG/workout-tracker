//
//  AppDelegate.swift
//  Workout3
//
//  Created by 108 on 23.03.16.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

var day_counter = 0




// determine device screen size

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height




func curr_time() ->String{
    
    
    /*
    // get the current date and time
    let currentDateTime = Date()
    
    // get the user's calendar
    let userCalendar = Calendar.current
    */
    
    /*
    
    // choose which date and time components are needed
    let requestedComponents: NSCalendar.Unit = [
        NSCalendar.Unit.year,
        NSCalendar.Unit.month,
        NSCalendar.Unit.day,
        
        // keep in mind
        //NSCalendarUnit.Hour,
        //NSCalendarUnit.Minute,
        //NSCalendarUnit.Second
    ]
    
    */
    
    let date = Date()
    let calendar = Calendar.current
    
    
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    
    
    /*
     let seconds = calendar.component(.second, from: date)
    */
 
    let month1 = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    let year = calendar.component(.year, from: date)
    
    // get the components
    
    /*
    let dateTimeComponents = (userCalendar as NSCalendar).components(requestedComponents, from: currentDateTime)

    
    let digits = dateTimeComponents.month
    */
 
 
    var month = ""
    /*
    switch String(describing: digits) {
    */
    switch String(describing: month1) {
    case "1":
        month = ("Jan")
    case "2":
        month = ("Feb")
    case "3":
        month = ("Mar")
    case "4":
        month = ("Apr")
    case "5":
        month = ("May")
    case "6":
        month = ("Jun")
    case "7":
        month = ("Jul")
    case "8":
        month = ("Aug")
    case "9":
        month = ("Sep")
    case "10":
        month = ("Oct")
    case "11":
        month = ("Nov")
    case "12":
        month = ("Dec")
    default:
        month = ("error")
    }
    
   
    /*
    return "\(month) \(dateTimeComponents.day), \(dateTimeComponents.year)"
    */
    
    return "\(month) \(day), \(year)"
    
    // keep in mind
    //dateTimeComponents.hour   // 17
    //dateTimeComponents.minute // 41
    //dateTimeComponents.second // 57
    
    
}

