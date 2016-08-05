//
//  PopoverPresentationController.swift
//  weibo
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class PopoverPresentationController: UIPresentationController {
    
    var presentFrame = CGRectZero
    /**
     初始化方法,返回
     
     - parameter presentedViewController:  被展现得控制器
     - parameter presentingViewController: 发起控制器
     
     - returns: 负责转场的对象
     */
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        
        print(presentedViewController)
        
    }
    
    override func containerViewWillLayoutSubviews() {
        //修改弹出试图尺寸
//        containerView 对应transitionView
//        presentedView 对应view
        if presentFrame == CGRectZero {
            presentedView()?.frame = CGRect(x: 100, y: 56, width: 200, height: 200)
        }else{
            presentedView()?.frame = presentFrame
        }
        
        
        //在容器视图上添加蒙板
        containerView?.insertSubview(coverView, atIndex: 0)
    }
    
    // MARK: -懒加载
    private lazy var coverView : UIView = {
        let view = UIView()
        view.frame = UIScreen.mainScreen().bounds
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        
        //添加监听
        let tap = UITapGestureRecognizer(target: self, action: #selector(PopoverPresentationController.close))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    //关闭popove view controller
    func close(){
        
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
