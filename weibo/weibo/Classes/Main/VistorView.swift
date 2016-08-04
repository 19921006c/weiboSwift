//
//  VistorView.swift
//  weibo
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

//Swift 定义协议,必须遵守NSObjectProtocol
protocol VistorViewDelegate: NSObjectProtocol{
    //点击登录回调
    func loginBtnDidAction()
    //点击注册回调
    func registerDidAction()
}

class VistorView: UIView {
    
    //定义一个属性保存代理对象
    //一定嫁weak 避免循环应用
    weak var delegate: VistorViewDelegate?
    /**
     设置为登录界面
     
     - parameter isHome:    是否为首页
     - parameter imageName: 图片name
     - parameter message:   内容
     */
    func setupVistorInfo(isHome : Bool, imageName: String, message: String){
        //如果不是首页就隐藏转盘
        iconImageView.hidden = !isHome
        homeIconImageView.image = UIImage(named: imageName)
        messageLabel.text = message
        
        //判断是否需要执行动画
        if isHome {
            startAnimation()
        }
    }

   override init(frame: CGRect) {
        super.init(frame: frame)
        
        //添加子控件
        addSubview(iconImageView)
        addSubview(maskBgView)
        addSubview(homeIconImageView)
        addSubview(messageLabel)
        addSubview(loginBtn)
        addSubview(registerBtn)
    
        //设置frame
        iconImageView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
        homeIconImageView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
        messageLabel.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: iconImageView, size: nil)
        //那个(控件)什么(属性)＝另外一个(空间)的什么(属性)x(多少)再＋(多少)
        let widthCons = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224)
        addConstraint(widthCons)
    
        registerBtn.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 20))
        loginBtn.xmg_AlignVertical(type: .BottomRight, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 20))
        maskBgView.xmg_Fill(self)
    
    }
    
    //swift 推荐自定义控件要么用纯代码，要么用xib
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loginBtnAction(){
        delegate?.loginBtnDidAction()
    }
    
    func registerBtnAction(){
        delegate?.registerDidAction()
    }
    
    // MARK: - 内部控制
    private func startAnimation(){
        //创建动画
        let animate = CABasicAnimation(keyPath: "transform.rotation")
        //设置动画属性
        animate.toValue = 2 * M_PI
        animate.duration = 20
        animate.repeatCount = MAXFLOAT
        //默认removedOnCompletion = ture 代表动画之行完毕就会移除
        animate.removedOnCompletion = false
        //将动画添加到图层上
        iconImageView.layer.addAnimation(animate, forKey: nil)
    }
    
    // MARK: - 懒加载控件
    //转盘图片
    private lazy var iconImageView : UIImageView = {
        let iconImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iconImageView
    }()
    
    //图标
    private lazy var homeIconImageView : UIImageView = {
        
        let homeIconImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        
        return homeIconImageView
    }()
    
    //文本label
    private lazy var messageLabel : UILabel = {
        let label = UILabel ()
        label.text = "sdokfoejroijdfoijrgoidfjgoir"
        label.numberOfLines = 0
        label.textColor = UIColor.grayColor()
        return label
    }()
    
    //登录按钮
    private lazy var loginBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.addTarget(self, action: #selector(VistorView.loginBtnAction), forControlEvents: .TouchUpInside)
        return btn
    }()
    //注册按钮
    private lazy var registerBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: .Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.addTarget(self, action: #selector(VistorView.registerBtnAction), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    private lazy var maskBgView : UIImageView = {
        let vi = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return vi
    }()

}
