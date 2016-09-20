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
    @IBOutlet weak var tipTF: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitTotalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tipTFChanged(sender: AnyObject) {
        let tip = Float(tipTF.text!) ?? 0
        let bill = Float(billTF.text!) ?? 0
        if(tip>0 && bill>0){
            let tipPercent:Float = tip/bill
            
            if(tipPercent > 1){
                slider.setValue(1, animated: false)
                segControl.setEnabled(true, forSegmentAtIndex: 4)
                tipPercentageLabel.text = "$0.00"
            }
            else{
                var segIndex = 4
                if(tipPercent < 0.15){
                    segIndex = 0
                }
                else if(tipPercent < 0.2){
                    segIndex = 1
                }
                else if(tipPercent<0.25){
                    segIndex = 2
                }
                else if(tipPercent<0.3){
                    segIndex = 3
                }
                
                slider.setValue(tipPercent, animated: false)
                tipPercentageLabel.text = String(format: "$%.2f%",tipPercent)
                segControl.setEnabled(false, forSegmentAtIndex: segIndex)
            }
        }
        else{
            slider.setValue(0, animated: false)
            segControl.setEnabled(true, forSegmentAtIndex: 0)
            tipPercentageLabel.text = "0.0%"
        }
    }
    
    @IBAction func segControlChanged(sender: AnyObject) {
        let bill = Double(billTF.text!) ?? 0
        let tipValues = [0.1, 0.15, 0.2, 0.25, 0.3]
        let tip = bill * tipValues[segControl.selectedSegmentIndex]
        tipPercentageLabel.text = String(format: "$%.1f", tipValues[segControl.selectedSegmentIndex])
        tipTF.text = String(format: "$%.2f", tip)
        
        let total = bill + tip
        
        totalLabel.text = String(format: "$%.2f", total)
        
        tipTF.text = String(format: "$%.2f", tip)

    }
    
    @IBAction func sliderChanged(sender: AnyObject) {
        
    }
    
    
        
        
//        let array = [0.1, 0.15, 0.2, 0.25, 0.3]
//        let segValue:Float = array[segControl.selectedSegmentIndex]
//        let sliderValue:Float = slider.value
//        if(segValue )
    
    
    @IBAction func calculate(sender: AnyObject) {
        let bill = Double(billTF.text!) ?? 0
        
        let tipValues = [0.1, 0.15, 0.2, 0.25, 0.3]
        
        let tip = bill * tipValues[segControl.selectedSegmentIndex]
        
        tipPercentageLabel.text = String(format: "$%.2f%", tipValues[segControl.selectedSegmentIndex])
        
        let total = bill + tip
        
        totalLabel.text = String(format: "$%.2f", total)
        
        tipTF.text = String(format: "$%.2f", tip)
        
    }
    
    

    @IBAction func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }

}

