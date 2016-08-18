//
//  FTChatMessageModel.swift
//  ChatMessageDemoProject
//
//  Created by liufengting https://github.com/liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

enum FTChatMessageDeliverStatus {
    case Sending
    case Succeeded
    case failed
}




/// FTChatMessageSenderModel

class FTChatMessageSenderModel : NSObject{
    
    var isUserSelf : Bool = false;
    var senderId : String!
    var senderName : String!
    var senderIconUrl : String!
    var senderExtraData : NSDictionary?
    
    convenience init(id : String? ,name : String?, icon_url : String?, extra_data : NSDictionary?, isSelf : Bool){
        self.init()
        senderId = id
        senderName = name
        senderIconUrl = icon_url
        senderExtraData = extra_data
        isUserSelf = isSelf
    }
}

 /// FTChatMessageModel

class FTChatMessageModel: NSObject {
    
    var targetId : String!
    var isUserSelf : Bool = false;
    var messageText : String!
    var messageTimeStamp : String!
    var messageType : FTChatMessageType = .Text
    var messageSender : FTChatMessageSenderModel!
    var messageExtraData : NSDictionary?
    var messageDeliverStatus : FTChatMessageDeliverStatus = FTChatMessageDeliverStatus.Succeeded

    
    convenience init(data : String? ,time : String?, from : FTChatMessageSenderModel, type : FTChatMessageType){
        self.init()
        self.transformMessage(data,time : time,extraDic: nil,from: from,type: type)
    }
    
    convenience init(data : String?,time : String?, extraDic : NSDictionary?, from : FTChatMessageSenderModel, type : FTChatMessageType){
        self.init()
        self.transformMessage(data,time : time,extraDic: nil,from: from,type: type)
    }
    
    private func transformMessage(data : String? ,time : String?, extraDic : NSDictionary?, from : FTChatMessageSenderModel, type : FTChatMessageType){
        messageType = type
        messageText = data
        messageTimeStamp = time
        messageSender = from
        isUserSelf = from.isUserSelf
        if (extraDic != nil) {
            messageExtraData = extraDic;
        }
    }

}




