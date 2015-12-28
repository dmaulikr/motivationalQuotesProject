//
//  quoteStore.swift
//  kept
//
//  Created by AnthonyAu on 12/2/15.
//  Copyright © 2015 anthonyau. All rights reserved.
//

import UIKit

class quoteStore {
    
    static let sharedInstance = quoteStore()
    var quoteManager: [quoteClass] = []
    
    //init will retrieve from database or initialize with empty quotes. should use nscoding
    private init() {
        //super.init()
        if let path = self.itemSavePath() {
            if let quotes = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [quoteClass] {
                quoteManager.appendContentsOf(quotes)
//                if you quotemanager = quotes, this will create a root memory leak. when you reference, you may create strong cycle. appending may or may not be making a copy of quotes. (need to check)
//                quoteManager = quotes
            }
        }       
    }
    
    //save quotes into directory
    func saveQuotes() -> Bool {
        if let path = self.itemSavePath() {
            let saveItems = self.quoteManager
            return NSKeyedArchiver.archiveRootObject(saveItems, toFile: path)
        } else {
            return false
        }
    }
    
    //clear all quotes from user defaults
    func clearQuotes() {
        self.quoteManager.removeAll()
    }
    
    //print all the quotes in the class
    func returnEntireQuoteClass() {
        for quotes in self.quoteManager {
            print(quotes.description)
        }
    }
    
    //retrieve item path for archive
    private func itemSavePath() -> String? {
        let directories = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        if let documentDirectory = directories.first {
            return documentDirectory + "/items.archive"
        }
        return nil
    }
    
    //delete a quote
    func deleteQuote(indexNumber: Int) {
        self.quoteManager.removeAtIndex(indexNumber)
    }
    
    //return a random quote
    func returnRandomQuote() -> quoteClass? {
        let numberOfQuotes = self.quoteManager.count
        if numberOfQuotes == 0 {
            return nil
        }
        let randomNumber = random() % numberOfQuotes
        return self.quoteManager[randomNumber]
    }
    
}