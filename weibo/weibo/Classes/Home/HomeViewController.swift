//
//  HomeViewController.swift
//  weibo
//
//  Created by J on 16/8/2.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import SVProgressHUD
class HomeViewController: BaseViewController,HomeViewControllerTitleButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userLogin {//没有登录
            vistorView?.setupVistorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        //初始化导航条
        initNav()
        
        //注册通知，监听菜单
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("change"), name: kPopoverAnimatorWillDismisx, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("change"), name: kPopoverAnimatorWillShow, object: nil)
    }
    
    func change()
    {
        //修改标题按钮的状态
        let titleBtn = navigationItem.titleView as! HomeViewControllerTitleButton
        titleBtn.selected = !titleBtn.selected
    }
    
    private func initNav()
    {
        //1.初始化左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.itemWithImageName("navigationbar_friendattention", target: self, action: Selector("leftDown"))
        navigationItem.rightBarButtonItem = UIBarButtonItem.itemWithImageName("navigationbar_pop", target: self, action: Selector("rightDown"))
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
        vc?.transitioningDelegate = popoverAnimator
        
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        //设置转场样式
        presentViewController(vc!, animated: true) {
            
        }
    }
    
    func leftDown(){
        
    }
    
    func rightDown(){
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        presentViewController(vc!, animated: true, completion: nil)
    }

    private func createBarButtonItem(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem{
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    
    //MARK: -懒加载    一定要定义一个属性保存自定义转场对象，否则报错
    private lazy var popoverAnimator: PopoverTool = {
        let pa = PopoverTool()
        pa.presentFrame = CGRect(x: 100, y: 56, width: 200, height: 350)
        return pa
    }()
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
