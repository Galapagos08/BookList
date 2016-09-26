//
//  AppDelegate.swift
//  BookList
//
//  Created by Dan Esrey on 2016/23/09.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        let rootViewController = window!.rootViewController as! UINavigationController
        let bvc = rootViewController.topViewController as! BooksViewController
        bvc.bookStore = BookStore()
        bvc.imageStore = ImageStore()

        
        return true
    }

 }

