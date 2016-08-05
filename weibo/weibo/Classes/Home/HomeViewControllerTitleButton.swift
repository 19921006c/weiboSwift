//
//  HomeViewControllerTitleButton.swift
//  weibo
//
//  Created by J on 16/8/3.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

protocol HomeViewControllerTitleButtonDelegate :NSObjectProtocol {
    func homeViewControllerTitleButtonDidSelected(sender: UIButton)
}
class HomeViewControllerTitleButton: UIButton {
    
    weak var delegate: HomeViewControllerTitleButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("Joe ", forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        sizeToFit()
        addTarget(self, action: #selector(HomeViewControllerTitleButton.btnAction(_:)), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //重写
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = CGRectGetMaxX((titleLabel?.frame)!)
    }
    
    func btnAction(sender: UIButton){
//        sender.selected = !sender.selected
        delegate?.homeViewControllerTitleButtonDidSelected(sender)
    }
    
}
