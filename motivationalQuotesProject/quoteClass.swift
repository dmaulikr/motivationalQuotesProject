//
//  quoteClass.swift
//  kept
//
//  Created by AnthonyAu on 12/2/15.
//  Copyright © 2015 anthonyau. All rights reserved.
//

import UIKit

class quoteClass: NSObject, NSCoding {
    
    var quoteText: String
    var author: String
    
    init(text: String, authorName: String) {
        quoteText = text
        author = authorName
    }
    
    override var description: String {
        return "quote: \(self.quoteText) author: \(self.author)"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.quoteText, forKey: "quoteText")
        aCoder.encodeObject(self.author, forKey: "author")
    }
    
    required init(coder aDecoder: NSCoder) {
        guard
            let text = aDecoder.decodeObjectForKey("quoteText") as? String,
            let artist = aDecoder.decodeObjectForKey("author") as? String
            else {
                quoteText = "Error occured. Best way is to delete this quote."
                author = "Sorry"
                return
            }
        quoteText = text
        author = artist
    }
}