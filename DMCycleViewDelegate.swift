//
//  DMCycleDelegate.swift
//  DMCycleView
//
//  Created by 李闯 on 6/4/17.
//  Copyright © 2017年 DamonLi. All rights reserved.
//

import UIKit

@objc protocol DMCycleViewDelegate:NSObjectProtocol{
    
    @available(iOS 2.0,*)
    @objc optional func tapImage(index:Int)
    
}
