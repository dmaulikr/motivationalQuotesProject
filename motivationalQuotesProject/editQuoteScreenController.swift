//
//  editQuoteScreenController.swift
//  kept
//
//  Created by AnthonyAu on 12/3/15.
//  Copyright © 2015 anthonyau. All rights reserved.
//

import UIKit

class editQuoteScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)! as UITableViewCell
        
        let quote = quoteStore.sharedInstance.quoteManager[indexPath.row]
        cell.textLabel?.text = quote.quoteText
        cell.detailTextLabel?.text = quote.author
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteStore.sharedInstance.quoteManager.count
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .Default, title: "Edit") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            if let editVC: submitQuoteScreenController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("addQuotesVC") as? submitQuoteScreenController {
                editVC.editQuote = quoteStore.sharedInstance.quoteManager[indexPath.row]
                editVC.indexPathToModify = indexPath
                self.presentViewController(editVC, animated: true, completion: nil)
            }
        }
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            quoteStore.sharedInstance.deleteQuote(indexPath.row)
            self.tableView.reloadData()
        }
        editAction.backgroundColor = UIColor.blackColor()
        deleteAction.backgroundColor = UIColor.blackColor()
        return [deleteAction, editAction]
    }

}
