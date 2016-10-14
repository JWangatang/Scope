//
//  FilterCell.swift
//  GithubDemo
//
//  Created by Jonathan Wang on 10/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var filterSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
