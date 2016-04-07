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
    var messageSenderLabel: UILabel!
    var messageBubbleItem: FTChatMessageBubbleItem!
    var message : FTChatMessageModel!
    
    var cellDesiredHeight : CGFloat = 60


    
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        
        
        
        
        
        message = theMessage
        
        
        
        
        var timeLabelRect = CGRectZero
        var nameLabelRect = CGRectZero
        var bubbleRect = CGRectZero
        
        
        if shouldShowSendTime {
            
            timeLabelRect = CGRectMake(0, -FTDefaultSectionHeight ,FTScreenWidth, FTDefaultTimeLabelHeight);
            nameLabelRect = CGRectMake(0, FTDefaultTimeLabelHeight - FTDefaultSectionHeight, FTScreenWidth, 0);

            messageTimeLabel = UILabel(frame: timeLabelRect);
            messageTimeLabel.text = "3月21日 16:44"
            messageTimeLabel.textAlignment = .Center
            messageTimeLabel.textColor = UIColor.lightGrayColor()
            messageTimeLabel.font = FTDefaultTimeLabelFont
            self.addSubview(messageTimeLabel)
        }else{
            nameLabelRect = CGRectMake(0, -FTDefaultSectionHeight, FTScreenWidth, 0);
        }
        
        if shouldShowSenderName {
            var nameLabelTextAlignment : NSTextAlignment = .Left
            
            if theMessage.isUserSelf {
                nameLabelRect = CGRectMake( 0, (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2  - FTDefaultSectionHeight  , FTScreenWidth - (FTDefaultMargin + FTDefaultIconSize + FTDefaultAngleWidth), FTDefaultNameLabelHeight)
                nameLabelTextAlignment =  .Right
            }else{
                nameLabelRect = CGRectMake(FTDefaultMargin + FTDefaultIconSize + FTDefaultAngleWidth, (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2  - FTDefaultSectionHeight ,FTScreenWidth, FTDefaultNameLabelHeight)
                nameLabelTextAlignment = .Left
            }
            messageSenderLabel = UILabel(frame: nameLabelRect);
            messageSenderLabel.text = "路人甲"
            messageSenderLabel.textAlignment = nameLabelTextAlignment
            messageSenderLabel.textColor = UIColor.lightGrayColor()
            messageSenderLabel.font = FTDefaultTimeLabelFont
            self.addSubview(messageSenderLabel)
        }
        
        
        
        
        
        var x : CGFloat = 0
        let y : CGFloat = nameLabelRect.origin.y + nameLabelRect.height + FTDefaultMargin
        var bubbleWidth : CGFloat = 200
        var bubbleHeight : CGFloat = 200

        
        


        
        if message.messageType == .Image {
            
            let image = UIImage(named : "dog.jpg")
            bubbleWidth = 200
            bubbleHeight = image == nil ? 200 : (image?.size.height)! * (200/(image?.size.width)!)
            x = theMessage.isUserSelf ? FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin) - bubbleWidth : FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
            
        }else{
            
            let att = NSString(string: message.messageText)
            let rect = att.boundingRectWithSize(CGSizeMake(FTDefaultTextInViewMaxWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], context: nil)
            
            bubbleWidth = rect.width + FTDefaultTextMargin*2 + FTDefaultAngleWidth
            bubbleHeight = rect.height + FTDefaultTextMargin*2
            x = theMessage.isUserSelf ? FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin) - bubbleWidth : FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin

            
        }
        
        bubbleRect = CGRectMake(x, y, bubbleWidth, bubbleHeight)
        self.cellDesiredHeight = bubbleRect.origin.y + bubbleHeight + FTDefaultMargin*2

        
        messageBubbleItem = FTChatMessageBubbleItem(frame: bubbleRect, aMessage: theMessage)
        self.addSubview(messageBubbleItem)

        
        
        
    }

    
    
}



