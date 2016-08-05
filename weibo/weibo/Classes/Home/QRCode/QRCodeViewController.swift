//
//  QRCodeViewController.swift
//  weibo
//
//  Created by J on 16/8/4.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeViewController: UIViewController, UITabBarDelegate {

    //扫描imageview
    @IBOutlet weak var scanImageView: UIImageView!
    //扫描imageview top 约束
    @IBOutlet weak var scanImageViewTop: NSLayoutConstraint!
    //扫描imageview 容器view height
    @IBOutlet weak var scanViewHeight: NSLayoutConstraint!
    @IBOutlet weak var customTabBar: UITabBar!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabBar.selectedItem = customTabBar.items![0]
    }

    @IBAction func closeBtnAction(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //开始扫描动画
        startAnimation()
        //扫描
        startScan()
    }
    
    private func startScan(){
        //1.判断是否能将输入添加到回话
        if !session.canAddInput(deviceInput){
            return
        }
        //2.判断是否能将输出添加到会话
        if !session.canAddOutput(deviceOutput){
            return
        }
        //3.将输入，输出添加到会话
        session.addInput(deviceInput)
        print(deviceOutput.metadataObjectTypes)
        session.addOutput(deviceOutput)
        print(deviceOutput.metadataObjectTypes)
        //4.设置输出能够解析的数据类型
        //设置解析数据类型，要在加入会议后设置
        deviceOutput.metadataObjectTypes = deviceOutput.availableMetadataObjectTypes
        //5.设置输出对象代理，只要解析出数据，通知代理
        deviceOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        //添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        //添加绘制图层到预览图层上
        previewLayer.addSublayer(drawLayer)
        //6.告诉session开始扫描
        session.startRunning()
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //修改容器高度
        //停止动画
        if item.title == "二维码" {
            print("二维码")
            scanViewHeight.constant = 200
        }else{
            scanViewHeight.constant = 100
            
            print("条形码")
        }
        scanImageView.layer.removeAllAnimations()
        startAnimation()
    }
    
    private func startAnimation()
    {
        scanImageViewTop.constant = -scanViewHeight.constant
        scanImageView.layoutIfNeeded()
        
        UIView.animateWithDuration(2.0, animations: {
            //1.修改约束
            self.scanImageViewTop.constant = self.scanViewHeight.constant
            //
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanImageView.layoutIfNeeded()
            }, completion: nil)
    }
    
    //MARK: -懒加载
    //1.会话
    private lazy var session : AVCaptureSession = AVCaptureSession()
    //2.输入对象
    private lazy var deviceInput : AVCaptureInput? = {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do{
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch{
            print(error)
            return nil
        }
    }()
    //3.输出对象
    private lazy var deviceOutput : AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
    //创建用来绘制变线的图层
    private lazy var drawLayer: CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate{
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        //
        label.text = metadataObjects.last?.stringValue
//        print(metadataObjects.last?.stringValue)
        
        //获取二维码位置
//        print(metadataObjects.last)
        //转换坐标
        for object in metadataObjects
        {
            if object is AVMetadataMachineReadableCodeObject
            {
                //转换为界面可识别坐标
                let codeObj = previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
//                print(codeObj)
                drawCorners(codeObj)
            }
        }
    }
    
    private func drawCorners(codeObj: AVMetadataMachineReadableCodeObject)
    {
        if codeObj.corners.isEmpty {
            return
        }
        
        //1.创建图层
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.redColor().CGColor
        //2.创建路径
//        layer.path = UIBezierPath(rect: CGRectMake(100, 100, 200, 200)).CGPath
        let path = UIBezierPath()
        var point = CGPointZero
        var index: Int = 0
        
        //移动到第一个点
        CGPointMakeWithDictionaryRepresentation((codeObj.corners[index++] as! CFDictionaryRef), &point)
        path.moveToPoint(point)
        //一定到其他的点
        while index < codeObj.corners.count {
            CGPointMakeWithDictionaryRepresentation(codeObj.corners[index++] as! CFDictionaryRef, &point)
            path.addLineToPoint(point)
        }
        
        path.closePath()
        
        //3.将绘制好的图层添加到drawLayer上
        drawLayer.addSublayer(layer)
    }
}