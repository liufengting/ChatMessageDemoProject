//
//  FTChatMessageInputView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/3/22.
//  Copyright © 2016年 liufengting https://github.com/liufengting . All rights reserved.
//

import UIKit

enum FTChatMessageInputMode {
    case Keyboard
    case Record
    case Accessory
    case None
}

protocol FTChatMessageInputViewDelegate {
    func ft_chatMessageInputViewShouldBeginEditing()
    func ft_chatMessageInputViewShouldEndEditing()
    func ft_chatMessageInputViewShouldUpdateHeight(desiredHeight : CGFloat)
    func ft_chatMessageInputViewShouldDoneWithText(textString : String)
    func ft_chatMessageInputViewShouldShowRecordView()
    func ft_chatMessageInputViewShouldShowAccessoryView()
}

class FTChatMessageInputView: UIToolbar, UITextViewDelegate{

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var accessoryButton: UIButton!

    var inputDelegate : FTChatMessageInputViewDelegate?
    var buttonBottomMargin : CGFloat = 10
    var textViewWidth : CGFloat = FTScreenWidth
    var textEdgeInset: UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)

    //MARK: - awakeFromNib -
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputTextView.layer.cornerRadius = FTDefaultInputViewTextCornerRadius
        inputTextView.layer.borderColor = FTDefaultIncomingColor.CGColor
        inputTextView.layer.borderWidth = 0.8
        inputTextView.textContainerInset = textEdgeInset
        inputTextView.delegate = self

    }
    
    //MARK: - layoutSubviews -
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.inputTextView.attributedText.length > 0 {
            self.inputTextView.scrollRangeToVisible(NSMakeRange(self.inputTextView.attributedText.length - 1, 1))
        }
    }
    
    //MARK: - recordButtonTapped -
    @IBAction func recordButtonTapped(sender: UIButton) {
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldShowRecordView()
        }
    }
    //MARK: - accessoryButtonTapped -
    @IBAction func accessoryButtonTapped(sender: UIButton) {
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldShowAccessoryView()
        }
    }
    
    //MARK: - clearText -
    func clearText(){
        inputTextView.text = ""
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldUpdateHeight(FTDefaultInputViewHeight)
        }
    }

    //MARK: - UITextViewDelegate -
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldBeginEditing()
        }
        return true
    }
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldEndEditing()
        }
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        if let text : NSAttributedString = textView.attributedText {
            let textRect = text.boundingRectWithSize(CGSizeMake(textView.bounds.width - textView.textContainerInset.left - textView.textContainerInset.right, CGFloat.max), options: [.UsesLineFragmentOrigin , .UsesFontLeading], context: nil);

            if (inputDelegate != nil) {
                inputDelegate!.ft_chatMessageInputViewShouldUpdateHeight(min(max(textRect.height + FTDefaultInputTextViewMargin*2 + textView.textContainerInset.top + textView.textContainerInset.bottom, FTDefaultInputViewHeight), FTDefaultInputViewMaxHeight))
            }
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if (textView.text as NSString).length > 0 {
                if (inputDelegate != nil) {
                    inputDelegate!.ft_chatMessageInputViewShouldDoneWithText(textView.text)
                    self.clearText()
                }
            }
            return false
        }
        return true
    }

    
}
