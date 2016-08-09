//
//  NewfeatureViewController.swift
//  weibo
//
//  Created by J on 16/8/8.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

private let identifier = "NewfeatureViewControllerCell"

class NewfeatureViewController: UICollectionViewController {
    
    private var layout: UICollectionViewFlowLayout = NewfeatureViewControllerLayout()
    /// 新特性页面个数
    private let pageCount = 4
    
    //
    init(){
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        //1.注册cell
        collectionView?.registerClass(NewfeatureViewControllerCell.self, forCellWithReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.bounces = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.pagingEnabled = true
        */
    }
    
    //MARK: - data source
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1.获取 cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! NewfeatureViewControllerCell
        //2.设置cell
        cell.contentView.backgroundColor = UIColor.redColor()
        cell.imageIndex = indexPath.item
        //3.返回cell
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        //indexPath 上一页索引
//        print(indexPath)
        
        //拿到当前显示的cell对应的索引
        let path = collectionView.indexPathsForVisibleItems().last!
        print(path)
        //拿到当前索引对应的cell
        let cell = collectionView.cellForItemAtIndexPath(path) as! NewfeatureViewControllerCell
        
        cell.startBtnAnimation()
    }
}

//swift中一个文件可以定义多个累
//如果当前类需要监听点击事件，类不能是私有的
class NewfeatureViewControllerCell: UICollectionViewCell{
    /// 保存图片索引
    //Swift 中，private修饰的 如果是同一个文件是可以访问的，不同文件的不能访问
    private var imageIndex: Int?{
        didSet{
            iconView.image = UIImage(named: "new_feature_\(imageIndex! + 1)")
            
            if imageIndex == 3
            {
                startBtn.hidden = false
            }
        }
    }
    
    /**
     让按钮做动画
     */
    private func startBtnAnimation(){
        //执行动画
        startBtn.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startBtn.userInteractionEnabled = false
        
        /**
        <#Description#>
        
        - parameter delay:                  <#delay description#>
        - parameter usingSpringWithDamping: <#usingSpringWithDamping description#>
        - parameter initialSpringVelocity:  <#initialSpringVelocity description#>
        - parameter options:                UIViewAnimationOptions(rawValue: 0) == OC KnilOptions
        - parameter animations:             <#animations description#>
        - parameter completion:             <#completion description#>
        
        - returns: <#return value description#>
        */
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startBtn.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                self.startBtn.userInteractionEnabled = true
        })
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI()
    {
        //1.添加子控件到contentview上
        contentView.addSubview(iconView)
        contentView.addSubview(startBtn)
        //2.布局子控件位置
        iconView.xmg_Fill(contentView)
        startBtn.xmg_AlignInner(type: XMG_AlignType.BottomCenter, referView: contentView, size: nil, offset: CGPoint(x: 0, y: -160))
    }
    
    private lazy var iconView = UIImageView()
    
    private lazy var startBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: .Highlighted)
        btn.hidden = true
        btn.addTarget(self, action: Selector("startBtnAction"), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    func startBtnAction(){
        NSNotificationCenter.defaultCenter().postNotificationName(KSwitchRootController, object: true)
    }
}

class NewfeatureViewControllerLayout: UICollectionViewFlowLayout{
    //准备布局
    //1.先调用一共有多少行
    //2.调用prepareLayout准备布局
    //3.返回cell
    override func prepareLayout() {
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.bounces = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.pagingEnabled = true
    }
}
