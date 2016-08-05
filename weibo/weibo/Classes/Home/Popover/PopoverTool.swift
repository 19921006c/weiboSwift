//
//  PopoverTool.swift
//  weibo
//
//  Created by J on 16/8/4.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

let kPopoverAnimatorWillShow = "kPopoverAnimatorWillShow"
let kPopoverAnimatorWillDismisx = "kPopoverAnimatorWillDismiss"

class PopoverTool: NSObject ,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning{
    
    //记录当前是否展开
    var isPresent : Bool = false
    
    //定义菜单的frame
    var presentFrame = CGRectZero
    
    //UIPresentationController 专用用于负责转场动画
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        let pc = PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
        pc.presentFrame = presentFrame
        return pc
    }
    
    // MARK: -只要实现了一下方法，
    /**
     modal动画
     
     - parameter presented:  被展示视图
     - parameter presenting: 发起视图
     - parameter source:
     
     - returns: 谁来负责
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        //通知home view controller presenting
        NSNotificationCenter.defaultCenter().postNotificationName(kPopoverAnimatorWillShow, object: nil)
        return self
    }
    
    /**
     dismiss 动画
     
     - parameter dismissed: 消失视图
     
     - returns: 谁来负责
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        //通知home view controller  dismiss
        NSNotificationCenter.defaultCenter().postNotificationName(kPopoverAnimatorWillDismisx, object: nil)
        return self
    }
    
    
    /**
     返回动画时长
     
     - parameter transitionContext: transitionContext description 上下文
     
     - returns: 动画时长
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.3
    }
    
    /**
     高速系统，无论展现还是消失都屌用这个方法
     
     - parameter transitionContext:
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        //        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        //        let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        //        print(toVc)
        //        print(fromVc)
        if isPresent {//展开
            
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            
            //一定将视图添加到容器上
            transitionContext.containerView()?.addSubview(toView!)
            
            //设置tuview锚点
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            toView?.transform = CGAffineTransformMakeScale(1.0, 0)
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                //清空transform
                toView?.transform = CGAffineTransformIdentity
            }) { (_) in
                //2.2
                //如果不写，可能导致一些未知错误
                transitionContext.completeTransition(true)
            }
        }else{//dismiss
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {//
                //CGFloat是不准确的,所以写0.0没有动画
                
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.00001)
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
            })
        }
        
        
    }
}
