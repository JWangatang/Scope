//
//  MovieDetailViewController.swift
//  Flixr
//
//  Created by Jonathan Wang on 10/2/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailViewController: UIViewController {
    @IBOutlet var movieTitleLabel: UILabel!

    @IBOutlet var movieOverviewLabel: UILabel!
    
    @IBOutlet var moviePosterImageView: UIImageView!
    
    var movie : NSDictionary!
    var imageURL : NSURL!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: subView.frame.origin.y + subView.frame.size.height + 20)
        
        movieTitleLabel.text = movie!["title"] as? String
        movieOverviewLabel.text = movie!["overview"] as? String
        
        if let imagePath = movie["poster_path"] as? String {
            let imageURL = NSURL(string: "https://image.tmdb.org/t/p/w500/" + imagePath)
            moviePosterImageView.setImageWithURL(imageURL!)
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
