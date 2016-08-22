//
//  FTChatMessageAccessoryView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/4/21.
//  Copyright © 2016年 liufengting https://github.com/liufengting . All rights reserved.
//

import UIKit

@objc protocol FTChatMessageAccessoryViewDataSource : NSObjectProtocol {

    func ftChatMessageAccessoryViewItemCount() -> NSInteger
    func ftChatMessageAccessoryViewImageForItemAtIndex(index : NSInteger) -> UIImage
    func ftChatMessageAccessoryViewTitleForItemAtIndex(index : NSInteger) -> String
 
}
@objc protocol FTChatMessageAccessoryViewDelegate : NSObjectProtocol {
    
    func ftChatMessageAccessoryViewDidTappedOnItemAtIndex(index : NSInteger)
    
}






class FTChatMessageAccessoryView: UIView, UIScrollViewDelegate{
    
    var accessoryDataSource : FTChatMessageAccessoryViewDataSource!
    var accessoryDelegate : FTChatMessageAccessoryViewDelegate!
    
    lazy var scrollView : UIScrollView = {
        let scroll : UIScrollView = UIScrollView(frame : self.bounds)
        scroll.backgroundColor = UIColor.clearColor()
        scroll.delegate = self
        scroll.pagingEnabled = true
        scroll.alwaysBounceVertical = false
        scroll.alwaysBounceHorizontal = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false;
        return scroll
    }()
    
    lazy var pageControl : UIPageControl = {
        let control : UIPageControl = UIPageControl(frame: CGRectMake(0, self.bounds.size.height - 20, self.bounds.width, 20))
        control.pageIndicatorTintColor = UIColor.grayColor()
        control.currentPageIndicatorTintColor = UIColor.whiteColor()
        return control
    }()
 

    convenience init(frame: CGRect , accessoryViewDataSource : FTChatMessageAccessoryViewDataSource , accessoryViewDelegate : FTChatMessageAccessoryViewDelegate) {
        self.init(frame:frame)
        
        self.backgroundColor = FTDefaultInputViewBackgroundColor

        
        accessoryDataSource = accessoryViewDataSource
        accessoryDelegate = accessoryViewDelegate
        self.setupAccessoryView()
    }
    
    func setupAccessoryView() {
        
        
        if accessoryDelegate == nil || accessoryDataSource == nil {
            NSException(name: "Notice", reason: "FTChatMessageAccessoryView. Missing accessoryDelegate or accessoryDelegate", userInfo: nil).raise()
            return
        }
        let totalCount = accessoryDataSource.ftChatMessageAccessoryViewItemCount()
        
        let totalPage = NSInteger(ceilf(Float(totalCount) / 8))
        self.pageControl.numberOfPages = totalPage
        self.addSubview(self.pageControl)
        self.scrollView.contentSize = CGSizeMake(self.bounds.width * CGFloat(totalPage), self.bounds.height)
        self.addSubview(self.scrollView)

        
        let horizontalMargin : CGFloat = 25
        let verticalMargin : CGFloat = 25
        let width : CGFloat = 60
        let height : CGFloat = width + 20
        let xMargin : CGFloat = (self.bounds.width - horizontalMargin*2 - width*4)/3
        let yMargin : CGFloat = (self.bounds.height - verticalMargin*2 - height*2)
 
        for i in 0...totalCount-1 {
            
            let currentPage = i / 8
            let indexForCurrentPage = i % 8
            
            let x = self.bounds.width * CGFloat(currentPage) + horizontalMargin + (xMargin + width)*CGFloat(i % 4)
            let y = verticalMargin + (yMargin + height) * CGFloat(indexForCurrentPage / 4)

            let item : FTChatMessageAccessoryItem = NSBundle.mainBundle().loadNibNamed("FTChatMessageAccessoryItem", owner: nil, options: nil)[0] as! FTChatMessageAccessoryItem
            item.frame  =  CGRectMake(x, y, width, height)
            
            let image = accessoryDataSource.ftChatMessageAccessoryViewImageForItemAtIndex(i)
            let string = accessoryDataSource.ftChatMessageAccessoryViewTitleForItemAtIndex(i)
            
            
            item.setupWithImage(image, name: string, index: i)
            item.addTarget(self, action: #selector(self.buttonItemTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollView.addSubview(item)
           
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentPage = lroundf(Float(scrollView.contentOffset.x/self.bounds.width))
        self.pageControl.currentPage = currentPage
    }

    
    func buttonItemTapped(sender : UIButton) {
        
        if (accessoryDelegate != nil) {
            accessoryDelegate.ftChatMessageAccessoryViewDidTappedOnItemAtIndex(sender.tag)
        }
        
    }


}
