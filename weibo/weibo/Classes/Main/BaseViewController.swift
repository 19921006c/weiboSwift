//
//  BaseViewController.swift
//  weibo
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,VistorViewDelegate {
    
    //定义一个变量，保存用户是否登录
    var userLogin = UserAccount.userLogin()
    
    var vistorView: VistorView?
    
    override func loadView() {
        userLogin ? super.loadView() : setupVistorView()
    }
    
    /**
     初始化为登录界面
     */
    private func setupVistorView(){
        let vi = VistorView()
        
        vi.delegate = self
        
        vistorView = vi
        
        view = vistorView
        
        //设置为登录导航条
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: Selector("leftBtnAction"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: Selector("rightBtnAction"))
        
    }
    
    func rightBtnAction(){
        
        loginBtnDidAction()
    }
    
    func leftBtnAction(){
        
        registerDidAction()
    }
    
    func loginBtnDidAction() {
        let controller = OAuthViewController()
        let navController = UINavigationController()
        navController.addChildViewController(controller)
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    func registerDidAction() {
        
    }

}
