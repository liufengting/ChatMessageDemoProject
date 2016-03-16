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
    
    var tableView : UITableView!
    
    
    var messageArray : [FTChatMessageModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sender = FTChatMessageSenderModel.init(id: "", name: "", icon_url: "", extra_data: nil, isSelf: false)
        let message = FTChatMessageModel.init(data: "奥斯卡的那款就卡死多久奥斯卡的那款就卡死多久奥斯卡的那款就卡死多久奥斯卡的那款就卡死多久奥斯卡的那款就卡死多久", time: "", from: sender, type: .Text)
        
        
        
        messageArray = [message]
        
        
        
        
        
        
        
        
        
        tableView = UITableView(frame: CGRectMake(0, 0, FTMarcors.screen_width, FTMarcors.screen_height), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None;
        tableView.allowsSelection = false
        self.view.addSubview(tableView)

    }
    /**
     UITableViewDelegate,UITableViewDataSource
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 100;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = FTChatMessageHeader(frame: CGRectMake(0,0,FTMarcors.screen_width,40), isSender: false, image: nil)

        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let message = messageArray[indexPath.row]
        
        let cell = FTChatMessageCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: FTChatMessageCellReuseIndentifier, aMessage: message, maxTextWidth: 300);
        
        //        cell.content = self.data[indexPath.row]
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
