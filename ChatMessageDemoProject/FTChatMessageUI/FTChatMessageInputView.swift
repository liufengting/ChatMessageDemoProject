//
//  FTChatMessageInputView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/3/22.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

protocol FTChatMessageInputViewDelegate {
    func FTChatMessageInputViewShouldUpdateHeight(desiredHeight : CGFloat)
    func FTChatMessageInputViewShouldDoneWithText(textString : String)
    func FTChatMessageInputViewShouldShowRecordView(shouldShowRecordView : Bool)
    func FTChatMessageInputViewShouldShowMoreFunctionView(shouldShowMoreFunctionView : Bool)
}

class FTChatMessageInputView: UIToolbar, UITextViewDelegate{

    var recordButton : UIButton!
    var inputTextView : UITextView!
    var addButton : UIButton!
    var inputDelegate : FTChatMessageInputViewDelegate?
    var buttonBottomMargin : CGFloat = 0
    var textViewWidth : CGFloat = FTScreenWidth
    var textEdgeInset: UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
    
    var isRecordViewOn : Bool = false
    var isMoreFunctionViewOn : Bool = false


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonBottomMargin = (self.bounds.height - FTDefaultInputButtonSize)/2
        
        recordButton = UIButton(frame:CGRectMake(FTDefaultInputViewMargin, self.bounds.height - FTDefaultInputButtonSize - buttonBottomMargin, FTDefaultInputButtonSize,FTDefaultInputButtonSize))
        recordButton.setBackgroundImage(UIImage(named: "FT_Record"), forState: .Normal)
        recordButton.backgroundColor = UIColor.clearColor()
        recordButton.addTarget(self, action: #selector(self.recordButtonTapped(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(recordButton)
        
        
        textViewWidth = FTScreenWidth - (FTDefaultInputViewMargin*4 + FTDefaultInputButtonSize*2)
        
        inputTextView = UITextView(frame: CGRectMake(FTDefaultInputViewMargin*2 + FTDefaultInputButtonSize, FTDefaultInputTextViewMargin , textViewWidth, self.bounds.height - FTDefaultInputTextViewMargin*2))
        inputTextView.font = FTDefaultFontSize
        inputTextView.layer.cornerRadius = FTDefaultInputViewMargin
        inputTextView.layer.borderColor = FTDefaultIncomingColor.CGColor
        inputTextView.layer.borderWidth = 0.8
        inputTextView.delegate = self
        inputTextView.bounces = false
        inputTextView.returnKeyType = .Send
        inputTextView.textContainerInset = textEdgeInset
        self.addSubview(inputTextView)
        
        addButton = UIButton(frame:CGRectMake(FTScreenWidth - FTDefaultInputButtonSize - FTDefaultInputViewMargin, self.bounds.height - FTDefaultInputButtonSize - buttonBottomMargin, FTDefaultInputButtonSize,FTDefaultInputButtonSize))
        addButton.setBackgroundImage(UIImage(named: "FT_Add"), forState: .Normal)
        addButton.backgroundColor = UIColor.clearColor()
        addButton.addTarget(self, action: #selector(self.addButtonTapped(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(addButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     recordButtonTapped:
     */
    func recordButtonTapped(sender : UIButton) {
        if (inputDelegate != nil) {
            inputDelegate!.FTChatMessageInputViewShouldShowRecordView(!isRecordViewOn)
            isRecordViewOn = !isRecordViewOn
        }
    }
    func addButtonTapped(sender : UIButton) {
        if (inputDelegate != nil) {
            inputDelegate!.FTChatMessageInputViewShouldShowMoreFunctionView(isMoreFunctionViewOn)
            isMoreFunctionViewOn = !isMoreFunctionViewOn
        }
    }
    
    
    /**
     clearText
     */
    func clearText(){
        inputTextView.text = ""
        if (inputDelegate != nil) {
            inputDelegate!.FTChatMessageInputViewShouldUpdateHeight(FTDefaultInputViewHeight)
        }
    }
    
    
    /**
     UITextViewDelegate
     
     - parameter textView: textView
     */
    

    
    func textViewDidChange(textView: UITextView) {
        if let text : NSString = textView.text as NSString {
            let textRect = text.boundingRectWithSize(CGSizeMake(textViewWidth - textView.textContainerInset.left - textView.textContainerInset.right, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize], context: nil);

            if (inputDelegate != nil) {
                inputDelegate!.FTChatMessageInputViewShouldUpdateHeight(min(max(textRect.height + FTDefaultInputTextViewMargin*2 + textView.textContainerInset.top + textView.textContainerInset.bottom, FTDefaultInputViewHeight), FTDefaultInputViewMaxHeight))
            }
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if (textView.text as NSString).length > 0 {
                if (inputDelegate != nil) {
                    inputDelegate!.FTChatMessageInputViewShouldDoneWithText(textView.text)
                }
            }
            return false;
        }
        return true;
    }
    

    
    /**
     drawRect
     
     - parameter rect: rect
     */
    func updateSubViewFrame() {
    
        self.recordButton.frame = CGRectMake(FTDefaultInputViewMargin, self.bounds.height - FTDefaultInputButtonSize - buttonBottomMargin, FTDefaultInputButtonSize,FTDefaultInputButtonSize)
        
        self.addButton.frame = CGRectMake(FTScreenWidth - FTDefaultInputButtonSize - FTDefaultInputViewMargin, self.bounds.height - FTDefaultInputButtonSize - buttonBottomMargin, FTDefaultInputButtonSize,FTDefaultInputButtonSize)
        
        self.inputTextView.frame = CGRectMake(FTDefaultInputViewMargin*2 + FTDefaultInputButtonSize, FTDefaultInputTextViewMargin, self.textViewWidth, self.bounds.height - FTDefaultInputTextViewMargin*2)
    }
    
}
