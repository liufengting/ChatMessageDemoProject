//
//  FTChatMessageRecordView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/4/20.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

class FTChatMessageRecordView: UIView {
    
    var recordButton : UIButton!
    

     override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.backgroundColor = FTDefaultIncomingColor
        
        recordButton = UIButton.init(frame: CGRectMake( (self.frame.size.width-FTDefaultRecordButtonSize)/2, (self.frame.height-FTDefaultRecordButtonSize)/2, FTDefaultRecordButtonSize, FTDefaultRecordButtonSize))
        recordButton.setTitle("Record", forState: .Normal)
        recordButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        recordButton.backgroundColor = FTDefaultOutgoingColor
        recordButton.layer.cornerRadius = FTDefaultRecordButtonSize/2
        recordButton.clipsToBounds = true
        self.addSubview(recordButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
