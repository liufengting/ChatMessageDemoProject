//
//  FTChatMessageTableViewController.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

//@objc
//public protocol ChartViewDelegate{
//    
//    optional func numberOfMessages() -> NSInteger
//
//    
//    
//}


class FTChatMessageTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    var messageTableView : UITableView!
    var messageInputView : FTChatMessageInputView!

    
    var messageArray : [FTChatMessageModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sender1 = FTChatMessageSenderModel.init(id: "", name: "", icon_url: "", extra_data: nil, isSelf: false)
        let sender2 = FTChatMessageSenderModel.init(id: "", name: "", icon_url: "", extra_data: nil, isSelf: true)

        
        let message1 = FTChatMessageModel(data: "最近有点无聊，抽点时间写了这个聊天的UI框架。", time: "", from: sender1, type: .Text)
        let message2 = FTChatMessageModel(data: "有什么功能", time: "", from: sender2, type: .Text)
        let message3 = FTChatMessageModel(data: "纯Swift编写，目前只写了纯文本消息，后续会有更多功能，TODO：图片视频语音定位等。这一版本还有很多需要优化，希望可以改成一个易拓展的方便大家使用，哈哈哈哈", time: "", from: sender1, type: .Text)
        let message4 = FTChatMessageModel(data: "不足的地方", time: "", from: sender2, type: .Text)
        let message5 = FTChatMessageModel(data: "文字背景不是图片，是用贝塞尔曲线画的，效率应该不高，后期优化", time: "", from: sender1, type: .Text)
        let message6 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈", time: "", from: sender2, type: .Text)

        
        
        
        
        
        
        messageArray = [message1,message2,message3,message4,message5,message6,
        message1,message2,message3,message4,message5,message6,
        message1,message2,message3,message4,message5,message6,
        message1,message2,message3,message4,message5,message6,
        message1,message2,message3,message4,message5,message6,
        message1,message2,message3,message4,message5,message6,]
        
        
        
        
        
        
        
        
        
        messageTableView = UITableView(frame: CGRectMake(0, 0, FTScreenWidth, FTScreenHeight), style: .Plain)
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.separatorStyle = .None
        messageTableView.allowsSelection = false
        messageTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        messageTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, FTDefaultInputViewHeight, 0)
        self.view.addSubview(messageTableView)
        
        let footer = UIView(frame: CGRectMake( 0, 0, FTScreenWidth, FTDefaultInputViewHeight))
        messageTableView.tableFooterView = footer
        
        messageInputView = FTChatMessageInputView(frame: CGRectMake(0, FTScreenHeight-FTDefaultInputViewHeight, FTScreenWidth, FTDefaultInputViewHeight), otherButtons: "")
        self.view.addSubview(messageInputView)

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FTChatMessageTableViewController.keyboradWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func keyboradWillChangeFrame(notification : NSNotification){
        
        if let userInfo = notification.userInfo {
            let duration = userInfo["UIKeyboardAnimationDurationUserInfoKey"]!.doubleValue
            let keyFrame = userInfo["UIKeyboardFrameEndUserInfoKey"]!.CGRectValue()
            
            let keyboradOriginY = min(keyFrame.origin.y, FTScreenHeight)
            
            UIView.animateWithDuration(duration, animations: { 
                
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, keyboradOriginY)
                self.messageInputView.frame = CGRectMake(0, keyboradOriginY-FTDefaultInputViewHeight, FTScreenWidth, FTDefaultInputViewHeight)
                
                }, completion: { (finished) in
                    if (finished){
//                        self.messageTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: self.messageArray.count-1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                    }
            })
        }
    }
    
    
    
    /**
     UITableViewDelegate,UITableViewDataSource
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return messageArray.count;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let message = messageArray[section]

        let header = FTChatMessageHeader(frame: CGRectMake(0,0,FTScreenWidth,40), isSender: message.messageSender.isUserSelf, image: nil)

        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cell : FTChatMessageCell = self.tableView(self.messageTableView, cellForRowAtIndexPath: indexPath) as! FTChatMessageCell
        
        return cell.cellDesiredHeight;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let message = messageArray[indexPath.section]
        
        let cell = FTChatMessageCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: FTChatMessageCellReuseIndentifier, aMessage: message, maxTextWidth: FTScreenWidth*0.7);
                
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
