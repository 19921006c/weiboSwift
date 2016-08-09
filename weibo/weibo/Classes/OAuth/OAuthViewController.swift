//
//  OAuthViewController.swift
//  weibo
//
//  Created by J on 16/8/5.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import SVProgressHUD
class OAuthViewController: UIViewController {
    
    let WB_AppKey = "26088830"
    let WB_Secret = "9fb1b60d4bbe41c8face7b9f7af2a2c8"
    let WB_Redirect_uri = "http://www.520it.com"
    let WB_url = "https://api.weibo.com/oauth2/authorize"

    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        let urlStr = "\(WB_url)?client_id=\(WB_AppKey)&redirect_uri=\(WB_Redirect_uri)"
        let url = NSURL(string: urlStr)
        let urlRequest = NSURLRequest(URL: url!)
        webView.loadRequest(urlRequest)
    }
    
    //MARK: -懒加载
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.delegate = self
        return webView
    }()
    
    private func setNavBar(){
        title = "微博登录"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: Selector("rightDown"))
    }
    
    func rightDown(){
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension OAuthViewController: UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showInfoWithStatus("正在加载...")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        //授权成功
        //取消授权
        let urlStr = request.URL!.absoluteString
        if !urlStr.hasPrefix(WB_Redirect_uri) {
            return true
        }
        
        //2.判断是否授权成功
        let codeStr = "code="
        
        if request.URL!.query!.hasPrefix(codeStr) {//授权成功
//            print("授权成功")
            let code = request.URL!.query?.substringFromIndex(codeStr.endIndex)
            
            //2.利用request token换取   access token
            loadAccessToken(code!)
        }else{//取消授权,关闭界面
//            print("取消成功")
            rightDown()
        }
//        print("-------\(request.URL?.absoluteString)")
        return false
    }
    
    //换取access token
    private func loadAccessToken(code: String){
        let path = "oauth2/access_token"
        
        let params = [
            "client_id" : WB_AppKey,
            "client_secret" : WB_Secret,
            "grant_type" : "authorization_code",
            "code" : code,
            "redirect_uri" : WB_Redirect_uri
        ]
        
        NetWorkingTool.share().POST(path, parameters: params, success: { (_, JSON) in
//            print(JSON)
            let account = UserAccount(dict: JSON as! [String : AnyObject])
            //加载用户信息
            account.loadUserInfo({ (account, error) -> () in
                //闭包回调成功后，保存用户信息
                if account != nil{
                    account!.saveAccout()
                    NSNotificationCenter.defaultCenter().postNotificationName(KSwitchRootController, object: false)
                    return
                }
                
                SVProgressHUD.showInfoWithStatus("网络不给力", maskType: .Black)
            })
            
//            print(account)
            //["access_token": 2.00dRiGyC0at9lBed9db6de91QtESPB, "uid": 2720446021, "expires_in": 157679999]
            }) { (_, error) in
            print(error)
        }
    }
}


