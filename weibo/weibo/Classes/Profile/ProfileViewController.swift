//
//  ProfileViewController.swift
//  weibo
//
//  Created by J on 16/8/2.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !userLogin {//没有登录
            vistorView?.setupVistorInfo(false, imageName: "visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料回显示在这里，展示给别人")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
