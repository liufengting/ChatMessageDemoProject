//
//  FTChatMessageRecordView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/4/20.
//  Copyright © 2016年 liufengting https://github.com/liufengting . All rights reserved.
//

import UIKit

class FTChatMessageRecordView: UIView {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = FTDefaultInputViewBackgroundColor
    }

    @IBAction func buttonTouchUpInside(sender: UIButton) {

    }
    @IBAction func buttonTouchUpOutside(sender: UIButton) {
        
    }
    @IBAction func buttonTouchDown(sender: UIButton) {
        
    }
    @IBAction func buttonTouchCancel(sender: UIButton) {
        
    }
    
    
    
    
}
