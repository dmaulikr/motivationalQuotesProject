//
//  submitQuoteScreenController.swift
//  kept
//
//  Created by AnthonyAu on 12/2/15.
//  Copyright © 2015 anthonyau. All rights reserved.
//

import UIKit

class submitQuoteScreenController: UIViewController {
   
    @IBOutlet weak var quoteTextField: UITextView!
    @IBOutlet weak var authorTextField: UITextField!
    
    //these optional variables will not be NIL when the user is editing the quote
    var editQuote: quoteClass?
    var indexPathToModify: NSIndexPath?
    
    @IBAction func submitQuotePressed(sender: AnyObject) {
        let quote = quoteClass(text: self.quoteTextField.text, authorName: self.authorTextField.text!)
        let quoteList = quoteStore.sharedInstance
        if self.indexPathToModify == nil {
            quoteList.quoteManager.append(quote)
        } else {
            quoteList.quoteManager[self.indexPathToModify!.row] = quote
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func endEditing(sender: AnyObject) {
       self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        if editQuote != nil {
            self.authorTextField.text = editQuote?.author
            self.quoteTextField.text = editQuote?.quoteText
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
