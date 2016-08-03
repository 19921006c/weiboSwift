//
//  MainTabBarController.swift
//  weibo
//
//  Created by J on 16/8/2.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置当前控制器的tabbar 颜色
        //在ios7 以前，如果设置tintColor只有文字变色，图片不变
        tabBar.tintColor = UIColor.orangeColor()
        
        //获取json文件路径
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        
        if let jsonPath = path {
            let jsonData = NSData(contentsOfFile: jsonPath)
            
            do{//有可能发生异常的代码
                let dicArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers)
                
                for dict in dicArray as! [[String : String]]{
                    //报错原因
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
            }catch{//数据加载错误，从本地加载控制器
                //发生异常之后会执行的代码
                print(error)
                //1.创建首页
                addChildViewController("HomeViewController", title: "首页", imageName: "tabbar_home")
                addChildViewController("MessageViewController", title: "消息", imageName: "tabbar_message_center")
                addChildViewController("DiscoverViewController", title: "广场", imageName: "tabbar_discover")
                addChildViewController("ProfileViewController", title: "我", imageName: "tabbar_profile")
            }
            
        }
        
    }
    
    /**
     初始化子控制器
     
     - parameter childController: 子控制器
     - parameter title:           标题
     - parameter imageName:       图片
     */
    private func addChildViewController(viewControllerName: String, title: String, imageName: String) {
        
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
//        print(nameSpace)
        //将字符串转化为类
        //命名空间默认情况下是项目名称,命名空间是可以修改的
        //动态获取name space
        let cls : AnyClass? = NSClassFromString(nameSpace + "." + viewControllerName)
        
        //通过类创建对象
        //将AnyClass转换为指定类型
        let vcClass = cls as! UIViewController.Type
        //
        let viewController = vcClass.init()
        
//        print(vc)
//        print(viewController)
//        //1.1设置tabbar
        viewController.tabBarItem.image = UIImage(named: imageName)
        viewController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        viewController.title = title
        
        let nav = UINavigationController()
        
        nav.addChildViewController(viewController)
        
        addChildViewController(nav)
    }

}
