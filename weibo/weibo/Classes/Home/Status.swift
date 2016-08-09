//
//  Status.swift
//  weibo
//
//  Created by J on 16/8/8.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class Status: NSObject {
     /// 微博创建时间
    var created_at: String?
     /// 微博ID
    var id: Int = 0
    
     /// 微博内容
    var text: String?
    
     /// 微博来源
    var source: String?
    
     /// 配图数组
    var pic_urls: [[String: AnyObject]]?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dictionary)
    }
    
    /**
     覆盖这个方法，属性与字典里的key不一一对应，不回崩溃
     */
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
        /// 打印当前模型
    var properties = ["created_at", "id", "text", "source", "pic_urls",]
    override var description: String{
        let dictionary = dictionaryWithValuesForKeys(properties)
        return "\(dictionary)"
    }
}
