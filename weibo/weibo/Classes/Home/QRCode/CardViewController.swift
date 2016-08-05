//
//  CardViewController.swift
//  weibo
//
//  Created by J on 16/8/5.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我的名片"
        
        view.addSubview(imageView)
        imageView.xmg_AlignInner(type: XMG_AlignType.Center, referView: view, size: CGSize(width: 200, height: 200))
        
        //生成二维码
//        let qrCodeImage = creatQRCodeImage()
        
//        imageView.image = qrCodeImage
    }
    
//    private func creatQRCodeImage() -> UIImage{
//        let filter = CIFilter(name: "CIQRCodeGenerator")
//        
//        filter?.setDefaults()
//        
//        
//    }
    
    //MARK: -懒加载
    
    private lazy var imageView: UIImageView = UIImageView()

}
