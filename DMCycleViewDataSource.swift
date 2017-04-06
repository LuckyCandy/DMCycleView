//
//  DMCycleViewDataSource.swift
//  DMCycleView
//
//  Created by 李闯 on 5/4/17.
//  Copyright © 2017年 DamonLi. All rights reserved.
//

import UIKit

/*
 * DMCycleViewDataSource
 */
@objc protocol DMCycleViewDataSource:NSObjectProtocol{
    
    @available(iOS 2.0,*)
    func numberOfResource()->Int
    
    @available(iOS 2.0,*)
    func resourceForRowAt(index:Int) -> UIImageView
    
    @available(iOS 2.0,*)
    @objc optional func textForRowAt(index:Int) -> String
    
}


