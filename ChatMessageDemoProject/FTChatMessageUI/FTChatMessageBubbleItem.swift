//
//  FTChatMessageBubbleItem.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/3/23.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

class FTChatMessageBubbleItem: UIButton {
    
    var message = FTChatMessageModel()
    var messageBubblePath = UIBezierPath()
    var messageLabel : UILabel!

    
    convenience init(frame: CGRect, aMessage : FTChatMessageModel) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        message = aMessage
        
        messageBubblePath = self.getBubbleShapePathWithSize(frame.size, isUserSelf: aMessage.isUserSelf)
        
        let layer = CAShapeLayer()
        layer.path = messageBubblePath.CGPath
        layer.fillColor = aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.CGColor : FTDefaultIncomingColor.CGColor
        self.layer.addSublayer(layer)

        
        //text
        messageLabel = UILabel(frame: self.getTextRectWithSize(frame.size, isUserSelf: aMessage.isUserSelf));
        messageLabel.text = message.messageText
        messageLabel.numberOfLines = 0
        messageLabel.textColor = aMessage.messageSender.isUserSelf ? UIColor.whiteColor() : UIColor.blackColor()
        messageLabel.font = FTDefaultFontSize
        self.addSubview(messageLabel)
        let attributeString = NSMutableAttributedString(attributedString: messageLabel.attributedText!)
        attributeString.addAttributes([NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], range: NSMakeRange(0, (messageLabel.text! as NSString).length))
        messageLabel.attributedText = attributeString

        
        
        
        
        
        
    }
    
    
    
    func getTextRectWithSize(size:CGSize , isUserSelf : Bool) -> CGRect {
        let bubbleWidth = size.width - FTDefaultAngleWidth - FTDefaultMargin - FTDefaultTextMargin*2
        let bubbleHeight = size.height - FTDefaultMargin*2 - FTDefaultTextMargin*2
        let y = FTDefaultMargin + FTDefaultTextMargin
        let x : CGFloat = isUserSelf ? FTDefaultMargin + FTDefaultTextMargin : FTDefaultAngleWidth + FTDefaultTextMargin
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
        
        let bubbleWidth = size.width - FTDefaultAngleWidth - FTDefaultMargin
        let bubbleHeight = size.height - FTDefaultMargin*2
        let y = FTDefaultMargin
        
        if (isUserSelf){
            let x : CGFloat = FTDefaultMargin
            
            path.moveToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y))
            path.addLineToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y))
            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(-M_PI), clockwise: false);
            path.addLineToPoint(CGPointMake(x, y+bubbleHeight-FTDefaultMessageRoundCorner))
            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI_2), clockwise: false);
            path.addLineToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight))
            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI_2), endAngle: 0, clockwise: false);
            path.addLineToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner*2+FTDefaultAngleWidth))
            path.addQuadCurveToPoint(CGPointMake(x+bubbleWidth+FTDefaultAngleWidth, y+FTDefaultMessageRoundCorner), controlPoint: CGPointMake(x+bubbleWidth+2.5, y+FTDefaultMessageRoundCorner+3))
            path.addQuadCurveToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner+2), controlPoint: CGPointMake(x+bubbleWidth+4, y+FTDefaultMessageRoundCorner+1))
            path.addLineToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner))
            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(0), endAngle: CGFloat(-M_PI_2), clockwise: false);
            path.closePath()
        }else{
            let x = FTDefaultAngleWidth
            path.moveToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y))
            path.addLineToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y))
            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(-M_PI_2), endAngle: 0, clockwise: true);
            path.addLineToPoint(CGPointMake(x+bubbleWidth, y+bubbleHeight-FTDefaultMessageRoundCorner))
            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true);
            path.addLineToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight))
            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true);
            path.addLineToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner*2+FTDefaultAngleWidth))
            path.addQuadCurveToPoint(CGPointMake(x-FTDefaultAngleWidth, y+FTDefaultMessageRoundCorner), controlPoint: CGPointMake(x-2.5, y+FTDefaultMessageRoundCorner+3))
            path.addQuadCurveToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner+2), controlPoint: CGPointMake(x-4, y+FTDefaultMessageRoundCorner+1))
            path.addLineToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner))
            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI), endAngle: CGFloat(-M_PI_2), clockwise: true);
            path.closePath()
        }
        return path;
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var desiredHeight : CGFloat {
        get{
            return 100
        }
    }
    
    


    
}
