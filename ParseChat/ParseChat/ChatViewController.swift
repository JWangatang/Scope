//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Jonathan Wang on 9/26/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit
import Parse


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
   
    
    @IBOutlet weak var tableView: UITableView!
    var  messagesArray: NSArray = []
   
    @IBOutlet weak var messageTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        pullData()
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.pullData()
        refreshControl.endRefreshing()
    }
    
    func pullData () {
        let messages = PFQuery(className:"Message_fbuJuly2016")
        messages.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error:NSError?) -> Void in
            objects!.sort{$0.createdAt!.isEqual($0.createdAt!.laterDate($1.createdAt!))}
            self.messagesArray = objects!
            self.tableView.reloadData()
            
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendMessage(sender: AnyObject) {
        let message = PFObject(className:"Message_fbuJuly2016")
        
        message["text"] = messageTF.text
        message["user"] = PFUser.currentUser()
        
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("message saved")
                self.tableView.reloadData()
                // The object has been saved.
            } else {
                print("message not saved")
            }
        }

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as! PhotoCell
        cell.label!.text =  self.messagesArray[indexPath.row].objectForKey("text") as? String
        
        
        
//        
//        if (self.messagesArray[indexPath.row].objectForKey("user") != nil)
//        {
//            if(self.messagesArray[indexPath.row].objectForKey("user")!.username != nil){
//                cell.usernameLabel!.text = self.messagesArray[indexPath.row].objectForKey("user")!.username
//                
//            }
//        }
        
        return cell
    }

}
