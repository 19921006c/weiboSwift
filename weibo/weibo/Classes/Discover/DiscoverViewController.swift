//
//  DiscoverViewController.swift
//  weibo
//
//  Created by J on 16/8/2.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !userLogin {//没有登录
            vistorView?.setupVistorInfo(false, imageName: "", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }
    }

}
