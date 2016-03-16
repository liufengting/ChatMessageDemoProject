//
//  FTChatMessageMarcos.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

let FTChatMessageCellReuseIndentifier = "ChatMessageCellReuseIndentifier"

//let FTChatMessageLongitudeKey = "FTChatMessageLongitudeKey"
//let FTChatMessageLatitudeKey = "FTChatMessageLatitudeKey"

/**
 *  FTMarcors
 */
struct FTMarcors {
    static let screen_width = UIScreen.mainScreen().bounds.size.width
    static let screen_height = UIScreen.mainScreen().bounds.size.height
    static let default_margin : CGFloat = 5.0
    static let default_icon_size : CGFloat = 30.0
    static let default_Line_spacing : CGFloat = 2.0
    


}





/**
 FTChatMessageType
 
 - Text:     Text message
 - Image:    Image message
 - Audio:    Audio message
 - Video:    Video message
 - Location: Location message
 */
enum FTChatMessageType {
    case Text
    case Image
    case Audio
    case Video
    case Location
}



class FTChatMessagePublicMethods{
    class func getHeightWithWidth(width:CGFloat,text:NSString,font:UIFont)->CGFloat{
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = FTMarcors.default_Line_spacing
        let rect = text.boundingRectWithSize(CGSizeMake(width,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font,NSParagraphStyleAttributeName: paragraphStyle], context: nil)
        return rect.size.height
    }
    class func getWidthWithHeight(height:CGFloat,text:NSString,font:UIFont)->CGFloat{
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = FTMarcors.default_Line_spacing
        let rect = text.boundingRectWithSize(CGSizeMake(CGFloat(MAXFLOAT),height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font,NSParagraphStyleAttributeName: paragraphStyle], context: nil)
        return rect.size.width
    }
    
    
}







