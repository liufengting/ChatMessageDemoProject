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


class FTChatMessageTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,FTChatMessageInputViewDelegate{
    
    var messageTableView : UITableView!
    var messageInputView : FTChatMessageInputView!

    
    var messageArray : [FTChatMessageModel] = []
    let sender1 = FTChatMessageSenderModel.init(id: "1", name: "SomeOne", icon_url: "https://avatars1.githubusercontent.com/u/4414522?v=3&s=400", extra_data: nil, isSelf: false)
    let sender2 = FTChatMessageSenderModel.init(id: "2", name: "Liufengting", icon_url: "https://avatars1.githubusercontent.com/u/4414522?v=3&s=400", extra_data: nil, isSelf: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem.init(title: "A", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.addNewIncomingMessage)), animated: true)
        
        self.loadDefaultMessages()
        

        
        messageTableView = UITableView(frame: CGRectMake(0, 0, FTScreenWidth, FTScreenHeight), style: .Plain)
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.separatorStyle = .None
        messageTableView.allowsSelection = false
        messageTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        messageTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, FTDefaultInputViewHeight, 0)
        self.view.addSubview(messageTableView)

        let header = UIView(frame: CGRectMake( 0, 0, FTScreenWidth, FTDefaultMargin*2))
        messageTableView.tableHeaderView = header
        
        let footer = UIView(frame: CGRectMake( 0, 0, FTScreenWidth, FTDefaultInputViewHeight))
        messageTableView.tableFooterView = footer
        
        messageInputView = FTChatMessageInputView(frame: CGRectMake(0, FTScreenHeight-FTDefaultInputViewHeight, FTScreenWidth, FTDefaultInputViewHeight))
        messageInputView.inputDelegate = self
        self.view.addSubview(messageInputView)

        
        
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.messageTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: self.messageArray.count-1), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        }
        

    }
    func loadDefaultMessages(){
        let message1 = FTChatMessageModel(data: "最近有点无聊，抽点时间写了这个聊天的UI框架。", time: "4.12 21:09:50", from: sender1, type: .Text)
        let message2 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:51", from: sender2, type: .Text)
        let message3 = FTChatMessageModel(data: "纯Swift编写，目前只写了纯文本消息，后续会有更多功能，图片视频语音定位等。这一版本还有很多需要优化，希望可以改成一个易拓展的方便大家使用，哈哈哈哈", time: "4.12 21:09:52", from: sender1, type: .Text)
        let message4 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:53", from: sender2, type: .Text)
        let message5 = FTChatMessageModel(data: "文字背景不是图片，是用贝塞尔曲线画的，效率应该不高，后期优化", time: "", from: sender1, type: .Text)
        let message6 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:54", from: sender2, type: .Text)
        let message7 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:55", from: sender1, type: .Text)
        let message8 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:56", from: sender2, type: .Image)
        
        messageArray = [message1,message2,message3,message4,message5,message6,message7,message8]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FTChatMessageTableViewController.keyboradWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)

    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    
    }
    /**
     notification functions
     */
    func keyboradWillChangeFrame(notification : NSNotification) {
        
        if let userInfo = notification.userInfo {
            let duration = userInfo["UIKeyboardAnimationDurationUserInfoKey"]!.doubleValue
            let keyFrame = userInfo["UIKeyboardFrameEndUserInfoKey"]!.CGRectValue()
            let keyboradOriginY = min(keyFrame.origin.y, FTScreenHeight)
            
            UIView.animateWithDuration(duration, animations: {
                self.view.frame = CGRectMake(0, keyboradOriginY-FTScreenHeight, FTScreenWidth, FTScreenHeight)
                }, completion: { (finished) in
                    if (finished){
                        
                    }
            })
        }
    }

    
    
    //FTChatMessageInputViewDelegate
    func FTChatMessageInputViewShouldUpdateHeight(desiredHeight: CGFloat) {
        var origin = messageInputView.frame;
        origin.origin.y = origin.origin.y + origin.size.height - desiredHeight;
        origin.size.height = desiredHeight;
        
        messageTableView.frame = CGRectMake(0, origin.origin.y + FTDefaultInputViewHeight - FTScreenHeight, FTScreenWidth, FTScreenHeight)
        messageInputView.frame = origin
        messageInputView.updateSubViewFrame()
    }
    func FTChatMessageInputViewShouldDoneWithText(textString: String) {
        
        messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight)
        self.addNewMessage(textString)
        messageInputView.clearText()
        
    }
    
    func addNewIncomingMessage() {
        
        let message8 = FTChatMessageModel(data: "New Message", time: "4.12 22:42", from: sender1, type: .Text)
        
        messageArray.append(message8);
        
        messageTableView.insertSections(NSIndexSet.init(indexesInRange: NSMakeRange(messageArray.count-1, 1)), withRowAnimation: UITableViewRowAnimation.Bottom)
        
        self.scrollToBottom()
        
    }
    
    
    func addNewMessage(text:String) {
        
        let message8 = FTChatMessageModel(data: text, time: "4.12 22:43", from: sender2, type: .Text)

        messageArray.append(message8);
        
        messageTableView.insertSections(NSIndexSet.init(indexesInRange: NSMakeRange(messageArray.count-1, 1)), withRowAnimation: UITableViewRowAnimation.Bottom)
        
        self.scrollToBottom()
        
    }
    
    func scrollToBottom() {
        self.messageTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: self.messageArray.count-1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
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
        
        let cell = FTChatMessageCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: FTChatMessageCellReuseIndentifier, theMessage: message, shouldShowSendTime: true , shouldShowSenderName: true);
                
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }

}
