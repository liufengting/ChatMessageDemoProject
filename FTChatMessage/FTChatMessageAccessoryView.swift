//
//  FTChatMessageAccessoryView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/4/21.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

protocol FTChatMessageAccessoryViewDataSource {

    func ftChatMessageAccessoryViewItemCount() -> NSInteger
    func ftChatMessageAccessoryViewItemCountEachRow() -> NSInteger
    func ftChatMessageAccessoryViewItemSize() -> CGFloat
    func ftChatMessageAccessoryViewBackgroundColorForItemAtIndex(index : NSInteger) -> UIColor
    func ftChatMessageAccessoryViewImageForItemAtIndex(index : NSInteger) -> UIImage
    
    
    
}
protocol FTChatMessageAccessoryViewDelegate {
    
    func ftChatMessageAccessoryViewDidTappedOnItemAtIndex(index : NSInteger)
    
}


class FTChatMessageAccessoryView: UIView {
    
    var dataSource : FTChatMessageAccessoryViewDataSource!
    var delegate : FTChatMessageAccessoryViewDelegate!
    
    

    convenience init(frame: CGRect , accessoryViewDataSource : FTChatMessageAccessoryViewDataSource , accessoryViewDelegate : FTChatMessageAccessoryViewDelegate) {
        self.init(frame:frame)
        
        self.backgroundColor = FTDefaultIncomingColor
        dataSource = accessoryViewDataSource
        delegate = accessoryViewDelegate
        self.setupAccessoryView()
    }
    
    func setupAccessoryView() {
        if dataSource == nil || delegate == nil {
            NSException(name: "Notice", reason: "FTChatMessageAccessoryView. Missing dataSource or delegate", userInfo: nil).raise()
            return
        }
        let count = min(dataSource.ftChatMessageAccessoryViewItemCount(), FTDefaultAccessoryViewMaxTotalCount)
        let countEachRow = min(dataSource.ftChatMessageAccessoryViewItemCountEachRow(), FTDefaultAccessoryViewMaxEachRowCount)
        if countEachRow < 1 {
            NSException(name: "Notice", reason: "FTChatMessageAccessoryView. countEachRow is too small", userInfo: nil).raise()
            return
        }
        let width = min(dataSource.ftChatMessageAccessoryViewItemSize(),(FTScreenWidth - FTDefaultAccessoryViewDefaltMargin*2 - CGFloat(FTDefaultAccessoryViewMinMargin)*CGFloat(countEachRow-1))/CGFloat(countEachRow))
        let marginX = (FTScreenWidth - FTDefaultAccessoryViewDefaltMargin*2 - CGFloat(countEachRow) * width)/(CGFloat(countEachRow) - 1)
        var marginY : CGFloat = 0
        let row = CGFloat(ceil(Double(count)/Double(countEachRow)))
        
        if row > 2 {
            NSException(name: "Notice", reason: "FTChatMessageAccessoryView. countEachRow is too small", userInfo: nil).raise()
            return
        }else if row == 2 {
            marginY = (FTDefaultRecordViewHeight - width * row - marginX * (row - 1))/2
        }else{
            marginY = FTDefaultAccessoryViewDefaltMargin
        }

        for i in 0...count-1 {
            
            let x = CGFloat(i % countEachRow) * (width + marginX) + FTDefaultAccessoryViewDefaltMargin
            let y = CGFloat(i / countEachRow) * (width + marginX) + marginY
            
            let button = UIButton(frame : CGRectMake( x, y, width, width));
            button.backgroundColor = dataSource.ftChatMessageAccessoryViewBackgroundColorForItemAtIndex(i)
            button.setImage(dataSource.ftChatMessageAccessoryViewImageForItemAtIndex(i), forState: UIControlState.Normal)
            button.layer.cornerRadius = width*0.1
            button.clipsToBounds = true
            button.tag = i
            button.addTarget(self, action: #selector(self.buttonItemTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
            
        }
        
        
        
    }
    
    func buttonItemTapped(sender : UIButton) {
        
        if (delegate != nil) {
            delegate.ftChatMessageAccessoryViewDidTappedOnItemAtIndex(sender.tag)
        }
        
    }


}
