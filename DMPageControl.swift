//
//  DMPageControl.swift
//  DMCycleView
//
//  Created by 李闯 on 6/4/17.
//  Copyright © 2017年 DamonLi. All rights reserved.
//

import UIKit

class DMPageControl: UIView {
    /*可以自己设定Dot的大小*/
    private let dotSize:CGSize = CGSize(width: 10, height: 10)
    private let defaultSpace:CGFloat = 5.0

    open var activeImage:UIImage?
    
    open var inactiveImage:UIImage?
    
    open var space:CGFloat?
    
    private var pages:Int!
    
    private var currentPage:Int! = 0
    
    init(frame: CGRect, withPages pages:Int) {
        super.init(frame: frame)
        activeImage = #imageLiteral(resourceName: "active.png")
        inactiveImage = #imageLiteral(resourceName: "inactive.png")
        self.pages = pages
        self.setup()
        self.isUserInteractionEnabled = true
        //self.backgroundColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        /*指定的frame算出最合适的space,直接指定space的优先级大于frame*/
        let maxSpace = (self.frame.size.width - CGFloat(pages) * dotSize.width) / CGFloat(pages - 1)
        
        if let space = self.space{
            self.space = space > maxSpace ? maxSpace : space
        }else{
            self.space = self.defaultSpace
        }
        /*增加dot--imageView*/
        let contentSize = CGSize(width: CGFloat(pages) * dotSize.width + CGFloat(pages - 1) * self.space!, height: dotSize.height)
        let otherSize = CGSize(width:(self.frame.size.width - contentSize.width) / 2, height: (self.frame.size.height - dotSize.height) / 2)
        for index in 0..<pages{
            let x_dot = otherSize.width + (dotSize.width + self.space!) * CGFloat(index)
            let dotView = UIImageView(frame: CGRect(x: x_dot, y: otherSize.height, width: dotSize.width, height: dotSize.height))
            if index == currentPage{
                dotView.image = activeImage
            }else{
                dotView.image = inactiveImage
            }
            
            self.addSubview(dotView)
        }
    }
    
    private func updateStatus(){
        for index in 0..<self.subviews.count {
            let imageView = self.subviews[index] as? UIImageView
            if self.currentPage == index{
                imageView?.image = activeImage
            }else{
                imageView?.image = inactiveImage
            }
        }
    }
    
    public func setCurrentPage(page:Int){
        self.currentPage = page
        self.updateStatus()
    }
}
