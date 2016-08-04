//
//  AppDelegate.swift
//  weibo
//
//  Created by J on 16/8/2.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //设置导航条和tabbar外观
        //外观一旦设置就全局有效,所以在程序一进来就设置
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        
        //1.创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        //2.创建根控制器
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        return true
    }

}

