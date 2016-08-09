//
//  String+Category.swift
//  weibo
//
//  Created by J on 16/8/8.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

extension String{
    
//    let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
//    let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
    
    /**
     将当前字符串拼接到cache目录后面
     */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /**
     将当前字符串拼接到cache目录后面
     */
    func docDic() -> String{
        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /**
     将当前字符串拼接到cache目录后面
     */
    func tmpDir() -> String{
        let path = NSTemporaryDirectory() as NSString
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
}
