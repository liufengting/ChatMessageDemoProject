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
    func ftChatMessageInputViewShouldBeginEditing()
    func ftChatMessageInputViewShouldEndEditing()
    func ftChatMessageInputViewShouldUpdateHeight(desiredHeight : CGFloat)
    func ftChatMessageInputViewShouldDoneWithText(textString : String)
    func ftChatMessageInputViewShouldShowRecordView()
    func ftChatMessageInputViewShouldShowAccessoryView()
}

class FTChatMessageInputView: UIToolbar, UITextViewDelegate{

//    var recordButton : UIButton!
//    var inputTextView : UITextView!
//    var accessoryButton : UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var accessoryButton: UIButton!
    
    
    
    var inputDelegate : FTChatMessageInputViewDelegate?
    var buttonBottomMargin : CGFloat = 10
    var textViewWidth : CGFloat = FTScreenWidth
    var textEdgeInset: UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
    

//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        buttonBottomMargin = (self.bounds.height - FTDefaultInputButtonSize)/2
//        
//        recordButton = UIButton(frame:CGRectMake(FTDefaultInputViewMargin, self.bounds.height - FTDefaultInputButtonSize - buttonBottomMargin, FTDefaultInputButtonSize,FTDefaultInputButtonSize))
//        recordButton.setBackgroundImage(UIImage(named: "FT_Record"), forState: .Normal)
//        recordButton.backgroundColor = UIColor.clearColor()
//        recordButton.addTarget(self, action: #selector(self.recordButtonTapped(_:)), forControlEvents: .TouchUpInside)
//        self.addSubview(recordButton)
//        
//        
//        textViewWidth = FTScreenWidth - (FTDefaultInputViewMargin*4 + FTDefaultInputButtonSize*2)
//        
//        inputTextView = UITextView(frame: CGRectMake(FTDefaultInputViewMargin*2 + FTDefaultInputButtonSize, FTDefaultInputTextViewMargin , textViewWidth, self.bounds.height - FTDefaultInputTextViewMargin*2))
//        inputTextView.font = FTDefaultFontSize
//        inputTextView.layer.cornerRadius = FTDefaultInputViewMargin
//        inputTextView.layer.borderColor = FTDefaultIncomingColor.CGColor
//        inputTextView.layer.borderWidth = 0.8
//        inputTextView.delegate = self
//        inputTextView.bounces = false
//        inputTextView.returnKeyType = .Send
//        inputTextView.textContainerInset = textEdgeInset
//        self.addSubview(inputTextView)
//        
//        accessoryButton = UIButton(frame:CGRectMake(FTScreenWidth - FTDefaultInputButtonSize - FTDefaultInputViewMargin, self.bounds.height - FTDefaultInputButtonSize - buttonBottomMargin, FTDefaultInputButtonSize,FTDefaultInputButtonSize))
//        accessoryButton.setBackgroundImage(UIImage(named: "FT_Add"), forState: .Normal)
//        accessoryButton.backgroundColor = UIColor.clearColor()
//        accessoryButton.addTarget(self, action: #selector(self.addButtonTapped(_:)), forControlEvents: .TouchUpInside)
//        self.addSubview(accessoryButton)
//
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputTextView.layer.cornerRadius = FTDefaultInputViewTextCornerRadius
        inputTextView.layer.borderColor = FTDefaultIncomingColor.CGColor
        inputTextView.layer.borderWidth = 0.8
        inputTextView.textContainerInset = textEdgeInset
        inputTextView.delegate = self

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (self.inputTextView.text as NSString).length > 0 {
            self.inputTextView.scrollRangeToVisible(NSMakeRange((self.inputTextView.text as NSString).length-1, 1))
            
        }
 
    }
    
    /**
     recordButtonTapped:
     */
    func recordButtonTapped(sender : UIButton) {
        if (inputDelegate != nil) {
            inputDelegate!.ftChatMessageInputViewShouldShowRecordView()
        }
    }
    func addButtonTapped(sender : UIButton) {
        if (inputDelegate != nil) {
            inputDelegate!.ftChatMessageInputViewShouldShowAccessoryView()
        }
    }
    
    
    /**
     clearText
     */
    func clearText(){
        inputTextView.text = ""
        if (inputDelegate != nil) {
            inputDelegate!.ftChatMessageInputViewShouldUpdateHeight(FTDefaultInputViewHeight)
        }
    }
    
    
    /**
     UITextViewDelegate
     
     - parameter textView: textView
     */
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if (inputDelegate != nil) {
            inputDelegate!.ftChatMessageInputViewShouldBeginEditing()
        }
        return true
    }
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if (inputDelegate != nil) {
            inputDelegate!.ftChatMessageInputViewShouldEndEditing()
        }
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        if let text : NSAttributedString = textView.attributedText {
            let textRect = text.boundingRectWithSize(CGSizeMake(textView.bounds.width - textView.textContainerInset.left - textView.textContainerInset.right, CGFloat.max), options: [.UsesLineFragmentOrigin , .UsesFontLeading], context: nil);

            if (inputDelegate != nil) {
                inputDelegate!.ftChatMessageInputViewShouldUpdateHeight(min(max(textRect.height + FTDefaultInputTextViewMargin*2 + textView.textContainerInset.top + textView.textContainerInset.bottom, FTDefaultInputViewHeight), FTDefaultInputViewMaxHeight))
            }
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if (textView.text as NSString).length > 0 {
                if (inputDelegate != nil) {
                    inputDelegate!.ftChatMessageInputViewShouldDoneWithText(textView.text)
                    self.clearText()
                }
            }
            return false
        }
        return true
    }
    
//    func drawingOptionCombine() -> NSStringDrawingOptions {
//        return UsesLineFragmentOrigin | UsesFontLeading
//    }
//    
    
//    (NSStringDrawingOptions)combine{
//    return NSStringDrawingTruncatesLastVisibleLine |
//    NSStringDrawingUsesLineFragmentOrigin |
//    NSStringDrawingUsesFontLeading;
//    }
    
    /**
     drawRect
     
     - parameter rect: rect
     */
//    func updateSubViewFrame() {
//    
//        self.recordButton.frame = CGRectMake(FTDefaultInputViewMargin, self.bounds.height - FTDefaultInputButtonSize - buttonBottomMargin, FTDefaultInputButtonSize,FTDefaultInputButtonSize)
//        
//        self.accessoryButton.frame = CGRectMake(FTScreenWidth - FTDefaultInputButtonSize - FTDefaultInputViewMargin, self.bounds.height - FTDefaultInputButtonSize - buttonBottomMargin, FTDefaultInputButtonSize,FTDefaultInputButtonSize)
//        
//        self.inputTextView.frame = CGRectMake(FTDefaultInputViewMargin*2 + FTDefaultInputButtonSize, FTDefaultInputTextViewMargin, self.textViewWidth, self.bounds.height - FTDefaultInputTextViewMargin*2)
//        
//        let textLength = (self.inputTextView.text as NSString).length
//        if textLength > 0 {
//            self.inputTextView.scrollRangeToVisible(NSMakeRange(textLength-1, 1))
//
//        }
//    }
    
}
