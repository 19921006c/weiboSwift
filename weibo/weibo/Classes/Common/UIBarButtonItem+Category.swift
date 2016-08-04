//
//  UIBarButtonItem+Category.swift
//  weibo
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    class func itemWithImageName(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem
    {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return UIBarButtonItem(customView: btn)
    }
}
