//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Jonathan Wang on 9/19/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var photoURL : NSURL!
    @IBOutlet weak var myImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myImage.setImageWithURL(photoURL)
        
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
