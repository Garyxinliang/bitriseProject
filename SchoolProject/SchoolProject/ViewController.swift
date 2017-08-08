//
//  ViewController.swift
//  SchoolProject
//
//  Created by XinLiang on 2017/7/26.
//  Copyright © 2017年 xi-anyunjingzhiwei. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import PromiseKit

class ViewController: UIViewController {
    
    var mainScrollView = UIScrollView.init()
    var mainBackView = UIView.init()
    var maxHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let animView = UIView.init()
        animView.backgroundColor = UIColor.green
        self.view.addSubview(animView)
        animView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(100)
        }
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(gesture:)))
        animView.addGestureRecognizer(tapGesture)
    }
    
    func tapAction(gesture : UITapGestureRecognizer) -> Void {
        let animView = gesture.view
        UIView.animate(withDuration: 0.3) {
            animView?.snp.updateConstraints({ (make) in
                make.center.equalTo(self.view).offset(50)
                make.width.equalTo(200)
            })
        }
    }
    
    func addTable() -> Void {
        self.view.backgroundColor = UIColor.green
        self.view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.view).offset(200)
            make.bottom.equalTo(self.view).offset(-200)
        }
        mainScrollView.backgroundColor = UIColor.red
        mainScrollView.bounces = false
        
        mainScrollView.addSubview(mainBackView)
        mainBackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(mainScrollView)
            make.width.height.greaterThanOrEqualToSuperview()
        }
        mainBackView.backgroundColor = UIColor.gray
        //顶部固定
        let length = 10
        
        for index in 0 ..< length {
            let tempLabel = UILabel.init()
            mainBackView.addSubview(tempLabel)
            tempLabel.text = "\(index)"
            tempLabel.textAlignment = NSTextAlignment.center
            tempLabel.backgroundColor = UIColor.orange
            tempLabel.layer.borderColor = UIColor.lightGray.cgColor
            tempLabel.layer.borderWidth = 1
            tempLabel.layer.cornerRadius = 4
            tempLabel.snp.makeConstraints({ (make) in
                let width = 80
                make.leading.equalTo(mainBackView).offset(index * width)
                make.top.equalTo(mainScrollView)
                make.height.equalTo(30)
                make.width.equalTo(width)
                if (index == length - 1){
                    make.trailing.equalTo(mainBackView.snp.trailing)
                }
            })
        }
        //底部可滑动区域
        for index in 0 ..< length {
            let innerNumber = Int(arc4random()%30)
            if innerNumber - 1 > maxHeight {
                maxHeight = innerNumber - 1
            }
            for innerIndex in 0..<innerNumber {
                let tempLabel = UILabel.init()
                mainBackView.addSubview(tempLabel)
                tempLabel.text = "\(index),\(innerIndex)"
                tempLabel.textAlignment = NSTextAlignment.center
                tempLabel.backgroundColor = UIColor.blue
                tempLabel.layer.borderColor = UIColor.white.cgColor
                tempLabel.layer.borderWidth = 1
                tempLabel.layer.cornerRadius = 4
                tempLabel.snp.makeConstraints({ (make) in
                    let width = 80
                    make.leading.equalTo(mainBackView).offset(index * width)
                    make.top.equalTo(mainBackView).offset(30 * (innerIndex + 1))
                    make.height.equalTo(30)
                    make.width.equalTo(width)
                    print(innerIndex, maxHeight)
                    if (innerIndex == maxHeight){
                        make.bottom.equalTo(mainBackView.snp.bottom).priority(500)
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

