//
//  AppDelegate.swift
//  weibo
//
//  Created by J on 16/8/2.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

/// 选择rootController 通知
let KSwitchRootController = "KSwitchRootController"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "swifthRootViewController:", name: KSwitchRootController, object: true)
        
        //设置导航条和tabbar外观
        //外观一旦设置就全局有效,所以在程序一进来就设置
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        
        //1.创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        //2.创建根控制器
        window?.rootViewController = defaultController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func swifthRootViewController(notification: NSNotification){
        
        print(notification.object)
//        if notification.object as! Bool {
//            
//        }else{
//        
//        }
        window?.rootViewController = MainTabBarController()
    }
    /**
     用于获取默认界面
     */
    private func defaultController() -> UIViewController
    {
        //用户是否登录
        if UserAccount.userLogin(){
            return isNewUpdate() ? NewfeatureViewController() : WelcomeViewController()
        }
        
        return MainTabBarController()
    }
    
    /**
     判断新版本
     */
    private func isNewUpdate() -> Bool{
        //1.获取当前版本号 -- info.plist
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
        //2.获取以前的版本号 -- 从本地缓存中拿
        //NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String 如果为空，则取lastVerion = ""
        var  lastVersion
        = NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? ""
        //3.比较版本号
        
//        print(currentVersion)
//        print(lastVersion)
        //3.1当前大于以前，则有新版本
        //3.1.1存储当前版本号
        //3.2当前 <= 以前， 则没有新版本
        if currentVersion?.compare(lastVersion) == NSComparisonResult.OrderedDescending//降序
        {
            //3.1.1存储当前版本号
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
            return true
        }
        
        return false
    }

}

