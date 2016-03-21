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
    var messageBubblePath = UIBezierPath()
    var message : FTChatMessageModel!
    

    
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, aMessage : FTChatMessageModel, maxTextWidth : CGFloat) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        
        message = aMessage
        
        
        let att = NSString(string: message.messageText)

        
        let rect = att.boundingRectWithSize(CGSizeMake(maxTextWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], context: nil)
        
        
        messageBubbleRect = self.getBubbleRectWithSize(rect.size, isUserSelf:  aMessage.isUserSelf)
        messageBubblePath = self.getBubbleShapePathWithSize(rect.size, isUserSelf: aMessage.isUserSelf)

        
//        let maskLayer = CAShapeLayer();
//        maskLayer.path = messageBubblePath.CGPath
//        maskLayer.fillColor =  aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.CGColor : FTDefaultIncomingColor.CGColor
//        maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
//        maskLayer.contentsScale = UIScreen.mainScreen().scale;
//        
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
        attributeString.addAttributes([NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], range: NSMakeRange(0, (messageLabel.text! as NSString).length))
        messageLabel.attributedText = attributeString
        
        
        
        
        
        cellDesiredHeight = max(messageBubbleRect.height + FTDefaultMargin*2 - FTDefaultSectionHeight, 0)

        
    }
    /**
     getBubbleRectWithSize
     
     - parameter size:       text size
     - parameter isUserSelf: isUserSelf
     
     - returns: CGRect
     */
    func getBubbleRectWithSize(size:CGSize , isUserSelf : Bool) -> CGRect {
        let bubbleWidth = size.width + FTDefaultTextMargin*2
        let bubbleHeight = size.height + FTDefaultTextMargin*2
        var x : CGFloat = 0
        var y : CGFloat = 0
        if (isUserSelf){
            x = FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin*3) - bubbleWidth
            y = -FTDefaultSectionHeight + FTDefaultMargin
        }else{
            x = FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
            y = -FTDefaultSectionHeight + FTDefaultMargin
        }
        return CGRectMake(x,y,bubbleWidth,bubbleHeight);
    }
    /**
     getBubbleShapePathWithSize
     
     - parameter size:       text size
     - parameter isUserSelf: isUserSelf
     
     - returns: UIBezierPath
     */
    func getBubbleShapePathWithSize(size:CGSize , isUserSelf : Bool) -> UIBezierPath {
        
        let path = UIBezierPath()

        let bubbleWidth = size.width + FTDefaultTextMargin*2
        let bubbleHeight = size.height + FTDefaultTextMargin*2
        
        if (isUserSelf){
            let x = FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin*3) - bubbleWidth
            let y = -FTDefaultSectionHeight + FTDefaultMargin
            path.moveToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y))
            path.addLineToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y))
            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(-M_PI), clockwise: false);
            path.addLineToPoint(CGPointMake(x, y+bubbleHeight-FTDefaultMessageRoundCorner))
            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI_2), clockwise: false);
            path.addLineToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight))
            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI_2), endAngle: 0, clockwise: false);
            path.addLineToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner*2+8))
            path.addQuadCurveToPoint(CGPointMake(x+bubbleWidth+8, y+FTDefaultMessageRoundCorner), controlPoint: CGPointMake(x+bubbleWidth+2.5, y+FTDefaultMessageRoundCorner+3))
            path.addQuadCurveToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner+2), controlPoint: CGPointMake(x+bubbleWidth+4, y+FTDefaultMessageRoundCorner+1))
            path.addLineToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner))
            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(0), endAngle: CGFloat(-M_PI_2), clockwise: false);
            path.closePath()
        }else{
            let x = FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
            let y = -FTDefaultSectionHeight + FTDefaultMargin
            path.moveToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y))
            path.addLineToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y))
            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(-M_PI_2), endAngle: 0, clockwise: true);
            path.addLineToPoint(CGPointMake(x+bubbleWidth, y+bubbleHeight-FTDefaultMessageRoundCorner))
            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true);
            path.addLineToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight))
            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true);
            path.addLineToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner*2+8))
            path.addQuadCurveToPoint(CGPointMake(x-8, y+FTDefaultMessageRoundCorner), controlPoint: CGPointMake(x-2.5, y+FTDefaultMessageRoundCorner+3))
            path.addQuadCurveToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner+2), controlPoint: CGPointMake(x-4, y+FTDefaultMessageRoundCorner+1))
            path.addLineToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner))
            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI), endAngle: CGFloat(-M_PI_2), clockwise: true);
            path.closePath()
        }
        return path;
    }

    
}



