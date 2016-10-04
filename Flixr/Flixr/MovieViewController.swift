//
//  MovieViewController.swift
//  Flixr
//
//  Created by Jonathan Wang on 10/2/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies : [NSDictionary]?
    var endpoint : String!
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //connect dataSource and delegate to the table view
        tableView.dataSource = self
        tableView.delegate = self
        
        //array of dictionaries, each dictionary being a movie
        
        
        //Network Request
        networkRequest()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.tintColor = tableView.tintColor
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func networkRequest () {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        isMoreDataLoading = false
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary{
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    self.tableView.reloadData()
                }
            }
        })
        task.resume()
    }
    
    func refreshControlAction (refreshControl : UIRefreshControl){
        networkRequest()
        refreshControl.endRefreshing()
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies {
            return movies.count
        }
        else{
            return 0
        }
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieTableViewCell
        let movie = self.movies![indexPath.row]
        let title = movie["title"] as! String
        cell.titleLabel!.text = title
        let description = movie["overview"] as! String
        cell.descriptionLabel!.text = description
        
        if let imagePath = movie["poster_path"] as? String {
            let imageURL = NSURL(string: "https://image.tmdb.org/t/p/w500/" + imagePath)
            cell.posterImageView.setImageWithURL(imageURL!)
        }
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if(!isMoreDataLoading){
            isMoreDataLoading = true
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                networkRequest()
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! MovieTableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        let destination = segue.destinationViewController as! MovieDetailViewController
        
        destination.movie = movies![indexPath!.row]
        
        //deselects cell's grey background
        tableView.deselectRowAtIndexPath(indexPath!, animated:true)

    }
    

}
