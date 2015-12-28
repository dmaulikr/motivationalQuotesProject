//
//  ViewController.swift
//  kept
//
//  Created by AnthonyAu on 12/2/15.
//  Copyright © 2015 anthonyau. All rights reserved.
//

import UIKit

class mainQuoteScreenController: UIViewController {

    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var quoteAuthor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAppearance()
    }

    override func viewWillAppear(animated: Bool) {
        self.returnRandomQuote()
        self.animateAppearance()
    }

    private func setAppearance() {
        let appearance = appearanceSettings()
        self.view.backgroundColor = appearance.backgroundColor
        self.quoteAuthor.textColor = appearance.fontColor
        self.quoteTextLabel.textColor = appearance.fontColor
    }
    
    private func animateAppearance() {
        self.quoteAuthor.transform = CGAffineTransformMakeScale(0.0, 0.0)
        self.quoteTextLabel.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        UIView.animateWithDuration(0.6, delay: 0.0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            self.quoteTextLabel.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.quoteAuthor.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: nil)
    }
    
    private func returnRandomQuote() {
        if let quote = quoteStore.sharedInstance.returnRandomQuote() {
            self.quoteAuthor.text = quote.author
            self.quoteTextLabel.text = quote.quoteText
        }
    }
    
    @IBAction func refreshQuote(sender: AnyObject) {
        self.returnRandomQuote()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
