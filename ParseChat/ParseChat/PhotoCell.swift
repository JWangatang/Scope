//
//  PhotoCell.swift
//  Tumblr
//
//  Created by Jonathan Wang on 9/19/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //cellImage = UIImageView(frame: CGRect(x: 0,y: 0,width: 240, height: 200))
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
