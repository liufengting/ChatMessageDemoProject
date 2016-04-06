//
//  FTChatMessageCell.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit






class FTChatMessageCell: UITableViewCell {

    var messageTimeLabel: UILabel!
    var message : FTChatMessageModel!
    var cellDesiredHeight : CGFloat = 60


    
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, aMessage : FTChatMessageModel, maxTextWidth : CGFloat) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        
        message = aMessage
        
        let timeLabel = UILabel(frame: CGRectMake(0, -FTDefaultSectionHeight ,FTScreenWidth, FTDefaultTimeLabelHeight));
        timeLabel.text = "3月21日 16:44"
        timeLabel.numberOfLines = 0
        timeLabel.textAlignment = .Center
        timeLabel.textColor = UIColor.lightGrayColor()
        timeLabel.font = FTDefaultTimeLabelFont
        self.addSubview(timeLabel)
        
        
        
        
        
        
        
        
//        image
        
        if message.messageType == .Image {
            
//            messageBubbleRect = CGRectMake(FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin, FTDefaultTimeLabelHeight - FTDefaultSectionHeight + FTDefaultMargin, 200, 150)
//
//            messageBubblePath = self.getBubbleShapePathWithSize(CGSizeMake(200, 150), isUserSelf: aMessage.isUserSelf)
//            
//            
//            let maskLayer = CAShapeLayer();
//            maskLayer.path = messageBubblePath.CGPath
//            maskLayer.frame = CGRectMake(0, -(FTDefaultTimeLabelHeight - FTDefaultSectionHeight + FTDefaultMargin), 200, 150)
//
//            maskLayer.contentsScale = UIScreen.mainScreen().scale;
//
//            
//            let layer = CAShapeLayer()
//            layer.mask = maskLayer
//            layer.frame = CGRectMake(FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin, FTDefaultTimeLabelHeight - FTDefaultSectionHeight + FTDefaultMargin, 200, 150)
//
//            
//            
//            
////            layer.fillColor =  aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.CGColor : FTDefaultIncomingColor.CGColor
////            layer.strokeColor =  aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.CGColor : FTDefaultIncomingColor.CGColor
//
//            self.layer.addSublayer(layer)
//            
//            if let image = UIImage(named : "Desktop.png"){
//                layer.contents = image.CGImage
////                image.drawInRect(messageBubbleRect)
//            }
            
            let image = UIImage(named : "dog.jpg")
            
            let bubbleWidth : CGFloat = 200
            let bubbleHeight : CGFloat = (image?.size.height)! * (200/(image?.size.width)!)
            let x : CGFloat = aMessage.isUserSelf ? FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin) - bubbleWidth : FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
            let y = FTDefaultTimeLabelHeight - FTDefaultSectionHeight

            
            
            
            self.cellDesiredHeight = bubbleHeight - FTDefaultSectionHeight + FTDefaultTimeLabelHeight

            
            let item = FTChatMessageBubbleItem(frame: CGRectMake(x,y,bubbleWidth,bubbleHeight), aMessage: aMessage)
            self.addSubview(item)


        }else{
            let att = NSString(string: message.messageText)
            let rect = att.boundingRectWithSize(CGSizeMake(maxTextWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], context: nil)
            
            

            let bubbleWidth = rect.width + FTDefaultTextMargin*2 + FTDefaultAngleWidth
            let bubbleHeight = rect.height + FTDefaultTextMargin*2
            let x : CGFloat = aMessage.isUserSelf ? FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin) - bubbleWidth : FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
            let y = FTDefaultTimeLabelHeight - FTDefaultSectionHeight + FTDefaultMargin
            
            self.cellDesiredHeight = bubbleHeight - FTDefaultSectionHeight + FTDefaultTimeLabelHeight + FTDefaultMargin*2

            let item = FTChatMessageBubbleItem(frame: CGRectMake(x,y,bubbleWidth,bubbleHeight), aMessage: aMessage)
            self.addSubview(item)
            

        }
        
    }

    
    
}



