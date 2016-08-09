//
//  NetWorkingTool.swift
//  weibo
//
//  Created by J on 16/8/5.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import AFNetworking

class NetWorkingTool: AFHTTPSessionManager {
    
    static let tools: NetWorkingTool = {
        let url = NSURL(string: "https://api.weibo.com/")
        let t = NetWorkingTool(baseURL: url)
        
        //设置afn能够接受的类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as! Set<String>
        
        return t
    }()
    
    class func share() -> NetWorkingTool{
        return tools
    }
}
