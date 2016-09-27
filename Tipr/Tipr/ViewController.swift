//
//  ViewController.swift
//  Tipr
//
//  Created by Jonathan Wang on 9/13/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billTF: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitTotalButton: UIButton!
    
    var tipPercent : Float = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func segControlChanged(sender: AnyObject) {
        let tipValues = [0.1, 0.15, 0.2, 0.25, 0.3]
        tipPercent = Float(tipValues[segControl.selectedSegmentIndex]);
        slider.setValue(tipPercent, animated: true)
        updateValues()
    }
    
    @IBAction func sliderChanged(sender: AnyObject) {
        tipPercent = slider.value;
        updateValues()
    }
    
    @IBAction func billChanged(sender: AnyObject) {
        updateValues()
    }
    
    func updateValues(){
        let bill = Double(billTF.text!) ?? 0
        
        let tip = Float(bill) * tipPercent
        tipLabel.text = String(format: "$%.2f", tip)
        
        let total = Float(bill) + tip
        totalLabel.text = String(format: "$%.2f", total)
        let tPercent = tipPercent*100
        tipPercentageLabel.text = String(format: "%.1f%%", tPercent)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let bill = Double(billTF.text!) ?? 0
        let tip = Float(bill) * tipPercent
        let total = Float(bill) + tip
        let vc = segue.destinationViewController as! SplitTotalViewController
        vc.totalValue = total
    }
}

