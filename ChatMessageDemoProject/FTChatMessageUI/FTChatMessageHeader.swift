//
//  FTChatMessageHeader.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit
import SDWebImage

class FTChatMessageHeader: UIView {
    
    internal var iconButton : UIButton!

    
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
        
        let iconRect = isSender ? CGRectMake(self.frame.width-FTMarcors.default_margin-FTMarcors.default_icon_size, FTMarcors.default_margin, FTMarcors.default_icon_size, FTMarcors.default_icon_size) : CGRectMake(FTMarcors.default_margin, FTMarcors.default_margin, FTMarcors.default_icon_size, FTMarcors.default_icon_size)
        if iconButton == nil{
            iconButton = UIButton.init()
        }
        iconButton.frame = iconRect
        iconButton.backgroundColor = UIColor.blackColor()
        iconButton.layer.cornerRadius = FTMarcors.default_icon_size/2;
        iconButton.clipsToBounds = true
        if image != nil{
            iconButton.setImage(image, forState: UIControlState.Normal)
        }else{
            iconButton.sd_setImageWithURL(imageUrl, forState: UIControlState.Normal, placeholderImage: UIImage())
        }
        self.addSubview(iconButton)

    }
    
    
    
    
    
    
    
    

}
