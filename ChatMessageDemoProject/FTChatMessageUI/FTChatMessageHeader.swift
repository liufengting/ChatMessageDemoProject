//
//  FTChatMessageHeader.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit
//import SDWebImage

class FTChatMessageHeader: UIView {
    
    var iconButton : UIButton!

    
    convenience init(frame: CGRect, isSender: Bool , imageUrl : NSURL?) {
        self.init(frame : frame)
        setupHeader(nil, imageUrl: imageUrl, isSender: isSender)
    }
    
    convenience init(frame: CGRect, isSender: Bool , image : UIImage?) {
        self.init(frame : frame)
        setupHeader(image, imageUrl: nil, isSender: isSender)
    }

    
    private func setupHeader(image: UIImage?, imageUrl : NSURL?, isSender: Bool){
        self.backgroundColor = UIColor.clearColor()
        
        let iconRect = isSender ? CGRectMake(self.frame.width-FTDefaultMargin-FTDefaultIconSize, FTDefaultMargin, FTDefaultIconSize, FTDefaultIconSize) : CGRectMake(FTDefaultMargin, FTDefaultMargin, FTDefaultIconSize, FTDefaultIconSize)
        iconButton = UIButton(frame: iconRect)
        iconButton.backgroundColor = isSender ? FTDefaultOutgoingColor : FTDefaultIncomingColor
        iconButton.layer.cornerRadius = FTDefaultIconSize/2;
        iconButton.clipsToBounds = true
        if image != nil{
            iconButton.setImage(image!, forState: UIControlState.Normal)
        }else if (imageUrl != nil){
            iconButton.sd_setImageWithURL(imageUrl!, forState: .Normal)
        }
        self.addSubview(iconButton)
    }

}
