//
//  SplitTotalViewController.swift
//  Tipr
//
//  Created by Jonathan Wang on 9/19/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit

class SplitTotalViewController: UIViewController {

    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var numberPeopleLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var totalPerPerson: UILabel!
    
    var totalValue : Float! = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        total.text = String (format: "$%.2f", totalValue)
        totalPerPerson.text = String (format: "$%.2f", totalValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperChanged(sender: AnyObject) {
        let numPeople = Int(stepper.value)
        numberPeopleLabel.text = String(numPeople)
        let newTotal = totalValue/Float(numPeople)
        totalPerPerson.text = String (format: "$%.2f", newTotal)
    }
}
