//
//  UserAccount.swift
//  weibo
//
//  Created by J on 16/8/5.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import SVProgressHUD
//swift 2.0 打印对象需要重写description get 方法 
class UserAccount: NSObject,NSCoding{
    
     ///
    var access_token: String?
    var expires_in: NSNumber?
        {
            didSet{
            expires_Date = NSDate(timeIntervalSinceNow: expires_in!.doubleValue)
            }
        }
    
    var expires_Date: NSDate?
    var uid: String?
    
    //当前用户昵称
    var screen_name: String?
    //用户头像
    var avatar_large: String?
    
    override init() {
        
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print(key)
    }
    
    override var description: String{
        let properties = ["access_token", "expires_in", "uid", "expires_Date", "screen_name", "avatar_large"]
        let dict = self.dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
    
    //返回用户是否登录
    class func userLogin() -> Bool
    {
        return loadAccount() != nil
    }
    
    static let accountPath = "account.plist".cacheDir()
    
    //保存数据
    func saveAccout()
    {
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
    }
    
    static var account: UserAccount?
    
    //读取数据
    class func loadAccount() -> UserAccount? {
        if account != nil
        {
            return account
        }
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
        
        //判断是否过期
        if account?.expires_Date?.compare(NSDate()) == NSComparisonResult.OrderedAscending
        {
            return nil
        }
        return account
    }
    
    
    //MARK: -NSCoding
    
    //写入
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
    //读取
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String;
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber;
        uid = aDecoder.decodeObjectForKey("uid") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
    }
    
    func loadUserInfo(finished: (account: UserAccount?, error: NSError?) -> ()){
        
        assert(access_token != nil, "没有授权")
        
        let path = "2/users/show.json"
        let param = ["access_token" : access_token!, "uid" : uid!]
        NetWorkingTool.share().GET(path, parameters: param, success: { (_, JSON) -> Void in
//            print(JSON)
            //判断字典是否有值
            if let dict = JSON as? [String : AnyObject]
            {
                self.screen_name = dict["screen_name"] as? String
                self.avatar_large = dict["avatar_large"] as? String
                //保存用户信息
                finished(account: self, error: nil)
                return
            }
            finished(account: nil, error: nil)
            }) { (_, error) -> Void in
                finished(account: nil, error: error)
        }
    }
}
