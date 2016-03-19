//
//  FTChatMessageCell.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit






class FTChatMessageCell: UITableViewCell {

    var cellDesiredHeight : CGFloat = 60

    var messageLabel : UILabel!
    var messageTimeLabel: UILabel!
    var messageBubbleRect : CGRect!
    let messageBubblePath = UIBezierPath()
    var message : FTChatMessageModel!
    

    
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, aMessage : FTChatMessageModel, maxTextWidth : CGFloat) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        
        message = aMessage
        
        
        let att = NSString(string: message.messageText)

        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = FTDefaultLineSpacing
        
        
        let rect = att.boundingRectWithSize(CGSizeMake(maxTextWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: paragraphStyle], context: nil)
        
        
        let bubbleWidth = rect.width + FTDefaultTextMargin*2
        let bubbleHeight = rect.height + FTDefaultTextMargin*2
        
        if (aMessage.messageSender.isUserSelf){


            let x = FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin*3) - bubbleWidth
            let y = -FTDefaultSectionHeight + FTDefaultMargin
            
            messageBubbleRect = CGRectMake(x,y,bubbleWidth,bubbleHeight)
            

            
            messageBubblePath.moveToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y))
            messageBubblePath.addLineToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y))
            messageBubblePath.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(-M_PI), clockwise: false);
            messageBubblePath.addLineToPoint(CGPointMake(x, y+bubbleHeight-FTDefaultMessageRoundCorner))
            messageBubblePath.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI_2), clockwise: false);
            messageBubblePath.addLineToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight))
            messageBubblePath.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI_2), endAngle: 0, clockwise: false);
            messageBubblePath.addLineToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner*2+12.0))
            
            
            
            
            messageBubblePath.addQuadCurveToPoint(CGPointMake(x+bubbleWidth+12.0, y+FTDefaultMessageRoundCorner), controlPoint: CGPointMake(x+bubbleWidth+3, y+FTDefaultMessageRoundCorner+3))
            messageBubblePath.addQuadCurveToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner+4), controlPoint: CGPointMake(x+bubbleWidth+7, y+FTDefaultMessageRoundCorner+3))
            
            
            
            
            messageBubblePath.addLineToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner))
            messageBubblePath.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(0), endAngle: CGFloat(-M_PI_2), clockwise: false);
            messageBubblePath.closePath()


        }else{


            let x = FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
            let y = -FTDefaultSectionHeight + FTDefaultMargin

            messageBubbleRect = CGRectMake(x,y,bubbleWidth,bubbleHeight)
            
            messageBubblePath.moveToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y))
            messageBubblePath.addLineToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y))
            messageBubblePath.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(-M_PI_2), endAngle: 0, clockwise: true);
            messageBubblePath.addLineToPoint(CGPointMake(x+bubbleWidth, y+bubbleHeight-FTDefaultMessageRoundCorner))
            messageBubblePath.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true);
            messageBubblePath.addLineToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight))
            messageBubblePath.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true);
            messageBubblePath.addLineToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner*2+12.0))
            messageBubblePath.addQuadCurveToPoint(CGPointMake(x-12.0, y+FTDefaultMessageRoundCorner), controlPoint: CGPointMake(x-3, y+FTDefaultMessageRoundCorner+3))
            messageBubblePath.addQuadCurveToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner+4), controlPoint: CGPointMake(x-7, y+FTDefaultMessageRoundCorner+3))
            
            messageBubblePath.addLineToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner))
            
            
            messageBubblePath.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI), endAngle: CGFloat(-M_PI_2), clockwise: true);
            messageBubblePath.closePath()
        }
        
        let layer = CAShapeLayer()
        layer.path = messageBubblePath.CGPath
        layer.fillColor = aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.CGColor : FTDefaultIncomingColor.CGColor
        self.layer.addSublayer(layer)

        
        
        
        
        
        
        
        
        messageLabel = UILabel(frame: CGRectMake(messageBubbleRect.origin.x+FTDefaultTextMargin,
            messageBubbleRect.origin.y+FTDefaultTextMargin, rect.width, rect.height));
        messageLabel.text = message.messageText
        messageLabel.numberOfLines = 0
        messageLabel.textColor = aMessage.messageSender.isUserSelf ? UIColor.whiteColor() : UIColor.blackColor()
        messageLabel.font = FTDefaultFontSize
        self.addSubview(messageLabel)

        
        
        let attributeString = NSMutableAttributedString(attributedString: messageLabel.attributedText!)
        attributeString.addAttributes([NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, (messageLabel.text! as NSString).length))
        messageLabel.attributedText = attributeString
        
        
        
        
        
        cellDesiredHeight = max(messageBubbleRect.height + FTDefaultMargin*2 - FTDefaultSectionHeight, 0)

        
        
        
        
    }
    
    


    

    
    

    
}



