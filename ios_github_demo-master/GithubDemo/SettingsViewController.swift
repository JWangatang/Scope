//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Jonathan Wang on 10/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var numberStarsLabel: UILabel!
    var sliderValue : Float!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = sliderValue
        numberStarsLabel.text = Int(sliderValue).description
        
        // Do any additional setup after loading the view.
    }

    @IBAction func doneButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sliderChanged(sender: AnyObject) {
        numberStarsLabel.text = Int(slider.value).description
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath) as! FilterCell
        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! RepoResultsViewController
        dest.searchSettings.minStars = Int(slider.value)
    }
    

}
