//
//  DetailsViewController.swift
//  GithubDemo
//
//  Created by Jonathan Wang on 10/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var repo: GithubRepo!

    @IBOutlet var handleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var forkLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var watchersLabel: UILabel!
    @IBOutlet var createdLabel: UILabel!
    @IBOutlet var updatedLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (repo != nil){
            handleLabel.text = repo.ownerHandle
            descriptionLabel.text = repo.repoDescription
            descriptionLabel.sizeToFit()
            forkLabel.text = repo.forks?.description
            starsLabel.text = repo.stars?.description
            nameLabel.text = repo.name
            imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: repo.ownerAvatarURL!)!)!)
            watchersLabel.text = repo.watchers?.description
            createdLabel.text = repo.createdAt
            updatedLabel.text = repo.updatedAt
            languageLabel.text = repo.language
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
