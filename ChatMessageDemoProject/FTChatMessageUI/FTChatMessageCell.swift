//
//  FTChatMessageCell.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit






class FTChatMessageCell: UITableViewCell {

    var messageLabel : UILabel!
    var messageTimeLabel: UILabel!
    var messageBubbleRect : CGRect!

    var message : FTChatMessageModel!

    
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, aMessage : FTChatMessageModel, maxTextWidth : CGFloat) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        
        message = aMessage
        
        
        let att = NSString(string: message.messageText)

        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = FTMarcors.default_Line_spacing
        
        
        let rect = att.boundingRectWithSize(CGSizeMake(maxTextWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(16),NSParagraphStyleAttributeName: paragraphStyle], context: nil)
        
        
        
        
        
        
        

//        let textHeight = FTChatMessagePublicMethods.getHeightWithWidth(maxTextWidth, text: message.messageText, font: UIFont.systemFontOfSize(16));
        
//
//        
//
//        let path = UIBezierPath(roundedRect: messageBubbleRect, cornerRadius: 5);
//        
//        let layer = CAShapeLayer()
//        layer.path = path.CGPath
//        layer.fillColor = UIColor.orangeColor().CGColor
//        self.layer.addSublayer(layer)
        
        
        let x = FTMarcors.default_icon_size + FTMarcors.default_margin*4
        let y = FTMarcors.default_margin - 35
        let width = rect.width + FTMarcors.default_margin*2
        let height = rect.height + FTMarcors.default_margin*2
        messageBubbleRect = CGRectMake(x,y,width,height)

        let margins : CGFloat = 8.0
        let angelWidth : CGFloat = 12.0
        let controlPointOffset : CGFloat = 3.0
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(x+margins, y))
        path.addLineToPoint(CGPointMake(x+width-margins, y))
        path.addArcWithCenter(CGPointMake(x+width-margins, y+margins), radius: margins, startAngle: CGFloat(-M_PI_2), endAngle: 0, clockwise: true);
        path.addLineToPoint(CGPointMake(x+width, y+height-margins))
        path.addArcWithCenter(CGPointMake(x+width-margins, y+height-margins), radius: margins, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true);
        path.addLineToPoint(CGPointMake(x+margins, y+height))
        path.addArcWithCenter(CGPointMake(x+margins, y+height-margins), radius: margins, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true);
        path.addLineToPoint(CGPointMake(x, y+margins*2+angelWidth))
        path.addQuadCurveToPoint(CGPointMake(x-angelWidth, y+margins), controlPoint: CGPointMake(x-angelWidth/2+controlPointOffset, y+margins+2+angelWidth/2-controlPointOffset))
        
        
        path.addQuadCurveToPoint(CGPointMake(x, y+margins+(angelWidth-margins)), controlPoint: CGPointMake(x-angelWidth/2-1, y+margins+(angelWidth-margins)/2+1))
        
        path.addLineToPoint(CGPointMake(x, y+margins))

        
        path.addArcWithCenter(CGPointMake(x+margins, y+margins), radius: margins, startAngle: CGFloat(M_PI), endAngle: CGFloat(-M_PI_2), clockwise: true);
        path.closePath()
        
        

        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.fillColor = UIColor.orangeColor().CGColor
//        layer.strokeColor = UIColor.orangeColor().CGColor

        self.layer.addSublayer(layer)

        
        
        
        
        
        
        
        
        messageLabel = UILabel(frame: CGRectMake(messageBubbleRect.origin.x+FTMarcors.default_margin,
            messageBubbleRect.origin.y+FTMarcors.default_margin, rect.width, rect.height));
        messageLabel.text = message.messageText
        messageLabel.numberOfLines = 0
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.font = UIFont.systemFontOfSize(15)
        self.addSubview(messageLabel)

        
        
        let attributeString = NSMutableAttributedString(attributedString: messageLabel.attributedText!)
        attributeString.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(16),NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, (messageLabel.text! as NSString).length))
        messageLabel.attributedText = attributeString
        
        
        
        
        
        
        
        
        
        
        
    }
    


    

    
    

    
}



