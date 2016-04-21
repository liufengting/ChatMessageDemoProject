//
//  FTChatMessageAccessoryView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/4/21.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

class FTChatMessageAccessoryView: UIView {

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.backgroundColor = FTDefaultOutgoingColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
