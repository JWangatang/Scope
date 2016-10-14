//
//  GitHubTableViewCell.swift
//  GithubDemo
//
//  Created by Jonathan Wang on 10/12/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class GitHubTableViewCell: UITableViewCell {

    @IBOutlet var handleLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    @IBOutlet var forksLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
