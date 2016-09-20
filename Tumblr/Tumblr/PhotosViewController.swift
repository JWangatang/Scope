//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Jonathan Wang on 9/19/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts:[NSDictionary] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 240
        
       self.pullData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell") as! PhotoCell
        
        let post = posts[indexPath.row]
        
        if let photos = post.valueForKeyPath("photos") as? [NSDictionary]{
            let imageUrlString = photos[0].valueForKeyPath("original_size.url") as? String
            if let imageUrl = NSURL(string: imageUrlString!){
                cell.cellImage.setImageWithURL(imageUrl)
            }
            else{
                print("Image URL is nil")
            }
        }
        else{
            print("Photos Dictionary is nil")
        }
        return cell
    }
    
//    func tableView:didSelectRowAtIndexPath{
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let dest = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        let post = posts[indexPath!.row]
        
        if let photos = post.valueForKeyPath("photos") as? [NSDictionary]{
            let imageUrlString = photos[0].valueForKeyPath("original_size.url") as? String
            if let imageUrl = NSURL(string: imageUrlString!){
                dest.photoURL = imageUrl
            }
            else{
                print("Image URL is nil")
            }
        }
        else{
            print("Photos Dictionary is nil")
        }
    }
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.pullData()
        refreshControl.endRefreshing()
    }
    
    func pullData () {
        let url = NSURL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,completionHandler: { (data, response, error) in if let data = data {
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData( data, options:[]) as? NSDictionary {
                
                print("responseDictionary: \(responseDictionary)")
                
                // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                // This is how we get the 'response' field
                
                let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                
                // This is where you will store the returned array of posts in your posts property
                self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                self.tableView.reloadData()
                
            }
            }
        });
        task.resume()

    }

}
