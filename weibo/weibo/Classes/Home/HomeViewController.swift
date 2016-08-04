//
//  HomeViewController.swift
//  weibo
//
//  Created by J on 16/8/2.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,HomeViewControllerTitleButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !userLogin {//没有登录
            vistorView?.setupVistorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        //初始化导航条
        initNav()
    }
    
    private func initNav()
    {
        //1.初始化左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.itemWithImageName("navigationbar_friendattention", target: self, action: #selector(HomeViewController.leftDown))
        navigationItem.rightBarButtonItem = UIBarButtonItem.itemWithImageName("navigationbar_pop", target: self, action: #selector(HomeViewController.rightDown))
        //初始化titleBtn
        let titleBtn = HomeViewControllerTitleButton()
        
        titleBtn.delegate = self
        
        navigationItem.titleView = titleBtn
    }
    
    func homeViewControllerTitleButtonDidSelected(sender: UIButton) {
//        print(sender)
        //弹出菜单
        let sb = UIStoryboard.init(name: "PopoverViewController", bundle: nil)
        
        let vc = sb.instantiateInitialViewController()
        
        //设置转场代理
        vc?.transitioningDelegate = self
        
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        //设置转场样式
        presentViewController(vc!, animated: true) {
            
        }
    }
    
    func leftDown(){
        
    }
    
    func rightDown(){
        
    }

    private func createBarButtonItem(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem{
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return UIBarButtonItem(customView: btn)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate{
    //UIPresentationController 专用用于负责转场动画
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}
