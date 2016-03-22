//
//  FTChatMessageInputView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/3/22.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

class FTChatMessageInputView: UIView {

    var textView : UITextView!
    
    

    
    
    
    convenience init(frame: CGRect, otherButtons: String) {
        self.init(frame : frame)
        
        self.backgroundColor = FTDefaultInputViewBackgroundColor;

        
        
        textView = UITextView(frame: CGRectMake(FTDefaultMargin, FTDefaultMargin, frame.width-FTDefaultMargin*10, frame.height-FTDefaultMargin*2))
        
        
        self.addSubview(textView)
        
        

    
    
    }
    
    
    
    
    
    
    
}
