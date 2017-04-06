//
//  DMCycleView.swift
//  DMCycleView
//
//  Created by 李闯 on 5/4/17.
//  Copyright © 2017年 DamonLi. All rights reserved.
//

import UIKit

/*
 * Indicator的显示位置
 */
public enum DMCycleViewIndicatorStyle:Int{
    
    case left
    
    case center
    
    case right
}


@available(iOS 2.0,*)
open class DMCycleView: UIView,UIScrollViewDelegate{
    
    weak var dataSource:DMCycleViewDataSource?{
        didSet{
            self.setup()
        }
    }
    
    weak var delegate:DMCycleViewDelegate?
    
    open var indicatorStyle:DMCycleViewIndicatorStyle = .right
    
    open var timeInterval:TimeInterval = 5
    
    private var maxItem:Int = 0
    
    private var scrollView:UIScrollView!
    
    private var bottomView:UIView!
    
    private var pageControl:DMPageControl!
    
    private var textLabel:UILabel?
    
    private var textArray = [String]()
    
    private var currentIndex:Int = 0
    
    private var timer:Timer?
    
    public init(frame: CGRect,DMCycleViewStyle style:DMCycleViewIndicatorStyle) {
        self.indicatorStyle = style
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    private func addBottomView(with indicatorstyle:DMCycleViewIndicatorStyle,isShowText:Bool){
        /*pageCotrol设置,如果需要展示文字内容那么IndicatorStyle会强制设置为right*/
        bottomView = UIView(frame: CGRect(x: 0, y: self.bounds.size.height - 30, width: self.bounds.size.width, height: 30))
        bottomView.backgroundColor = UIColor.clear
        bottomView.isUserInteractionEnabled = true
        if indicatorstyle == .left{
            pageControl = DMPageControl(frame: CGRect(x:0,y:0,width:self.bottomView.bounds.size.width / 4,height:30), withPages: maxItem)
        }else if indicatorstyle == .center{
            pageControl = DMPageControl(frame: CGRect(x:self.bottomView.bounds.size.width / 4,y:0,width:self.bottomView.bounds.size.width / 4,height:30), withPages: maxItem)
        }else{
            pageControl = DMPageControl(frame: CGRect(x:(self.bottomView.bounds.size.width * 0.75),y:0,width:self.bottomView.bounds.size.width / 4,height:30), withPages: maxItem)
            if isShowText{
                bottomView.backgroundColor = UIColor(white: 0, alpha: 0.6)
                //bottomView.alpha = 0.6
                self.textLabel = UILabel(frame: CGRect(x:10,y:0,width:self.bottomView.bounds.size.width * 0.75 - 10,height:30))
                self.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
                self.textLabel?.textColor = .white
                self.textLabel?.isUserInteractionEnabled = true
                bottomView.addSubview(self.textLabel!)
            }
        }
        bottomView.addSubview(pageControl)
        self.insertSubview(bottomView, aboveSubview: scrollView)
    }
    
    private func setup(){
        print("SetUp")
        /*轮播设置*/
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .red
        scrollView.delegate = self
        self.addSubview(scrollView)
        
        /*增加轮播内容*/
        maxItem = self.dataSource?.numberOfResource() ?? 0
        
        for index in 0..<maxItem{
            if let view = self.dataSource?.resourceForRowAt(index: index){
                let imageView = view as UIImageView
                imageView.frame = self.bounds
                imageView.frame.origin.x = self.bounds.size.width * CGFloat(index)
                imageView.isUserInteractionEnabled = true
                let tapGr = UITapGestureRecognizer(target: self, action: #selector(tapImage))
                imageView.addGestureRecognizer(tapGr)
                self.scrollView.addSubview(imageView)
            }
        }
        self.scrollView.contentSize = CGSize(width: self.bounds.size.width * CGFloat(maxItem), height: self.bounds.size.height)
        /*增加底部view*/
        if self.dataSource!.responds(to: #selector(DMCycleViewDataSource.textForRowAt(index:))){
            self.addBottomView(with: .right, isShowText: true)
            for index in 0..<maxItem{
                self.textArray.append(self.dataSource!.textForRowAt!(index: index))
            }
        }else{
            self.addBottomView(with: self.indicatorStyle, isShowText: false)
        }
    }
    
    public func start(){
        if self.timer != nil{
            self.timer?.invalidate()
            self.timer = nil
        }
        self.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        self.timer?.fire()
    }
    
    public func stop(){
        if self.timer != nil{
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    @objc private func scrollToNext(){
        if currentIndex == maxItem - 1{
            currentIndex = 0
        }else{
            currentIndex += 1
        }
        var frame = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(self.currentIndex)
        self.textLabel?.text = textArray[currentIndex]
        UIView.animate(withDuration: 1, animations: {[weak self] in
            self?.scrollView.scrollRectToVisible(frame, animated: true)
            self?.pageControl.setCurrentPage(page: (self?.currentIndex)!)
        })
        
    }
    
    @objc private func tapImage(){
        if let delegate = self.delegate{
            if delegate.responds(to: #selector(DMCycleViewDelegate.tapImage(index:))){
                delegate.tapImage!(index:currentIndex)
            }
        }
    }
    /*
     * ScrollView Delegate Implemention
     */
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.currentIndex = page
        self.textLabel?.text = textArray[currentIndex]
        self.pageControl.setCurrentPage(page: page)
    }
}
