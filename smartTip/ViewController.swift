//
//  ViewController.swift
//  smartTip
//
//  Created by Vinu Charanya on 12/5/15.
//  Copyright © 2015 vnu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var tipField: UITextField!
    @IBOutlet weak var tipAmountField: UITextField!
    @IBOutlet weak var totalField: UITextField!
    
    @IBOutlet weak var splitIntoField: UITextField!
    @IBOutlet weak var splitBillLabel: UILabel!
    @IBOutlet weak var splitTipLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBOutlet weak var splitSwitch: UISwitch!
    
    @IBOutlet weak var splitView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateValues(tipValue:Double=0.00,tipAmount:Double=0.00,totalAmount:Double=0.00) ->
        (tipValue:Double,tipAmount:Double,totalAmount:Double)
    {
        let billAmount = (priceField.text! as NSString).doubleValue
        splitBillLabel.text = "\(billAmount)"
        if(billAmount < 0){
            return(0,0,0)
        }
        var tipValue = tipValue
        var tipAmount = tipAmount
        var totalAmount = totalAmount
        if (tipAmount > 0){
            tipValue = (tipAmount * 100) / billAmount
            totalAmount = billAmount + tipAmount
        }else if(totalAmount > 0){
            tipAmount = totalAmount - billAmount
            tipValue = (tipAmount * 100) / billAmount
        }else if(tipValue > 0){
            tipAmount = (billAmount * tipValue/100)
            totalAmount = billAmount + tipAmount
        }
        return(round(tipValue), round(tipAmount), round(totalAmount));
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func updateAmount(){
        let tipValue = (tipField.text! as NSString).doubleValue
        let billValues = calculateValues(tipValue)
        tipAmountField.text = "\(billValues.tipAmount)"
        totalField.text = "\(billValues.totalAmount)"
    }
    
    @IBAction func onTotalEditingChanged(sender: AnyObject) {
        let totalAmount = (totalField.text! as NSString).doubleValue
        let billValues = calculateValues(totalAmount: totalAmount)
        tipField.text = "\(billValues.tipValue)"
        tipAmountField.text = "\(billValues.tipAmount)"
    }
    
    @IBAction func onTipAmountEditingChanged(sender: AnyObject) {
        print("Tip Amount Changed")
        let tipAmount = (tipAmountField.text! as NSString).doubleValue
        let billValues = calculateValues(tipAmount: tipAmount)
        tipField.text = "\(billValues.tipValue)"
        totalField.text = "\(billValues.totalAmount)"
    }
    
    @IBAction func onPriceEditingChanged(sender: AnyObject) {
        updateAmount()
    }

    @IBAction func onTipEditingChanged(sender: AnyObject) {
        updateAmount()
    }
    
    func updateSplitValues(){
        let splitInto = (splitIntoField.text! as NSString).doubleValue
        let billAmount = (priceField.text! as NSString).doubleValue / splitInto
        let tipAmount = (tipAmountField.text! as NSString).doubleValue / splitInto
        let totalAmount = billAmount + tipAmount
        splitBillLabel.text = String(format:"%.2f", billAmount)
        splitTipLabel.text = String(format:"%.2f", tipAmount)
        splitTotalLabel.text = String(format:"%.2f", totalAmount)
    }
    
    
    
    // Split Bill
    
    @IBAction func splitSwitchPressed(sender: AnyObject) {
        if(splitSwitch.on){
            splitView.hidden = false
            updateSplitValues()
        }else{
            splitView.hidden = true
        }
    }
    func updateSplit(byValue: Int){
        let splitInto = Int(splitIntoField.text!)
        if(byValue > 0 || (byValue < 0 && splitInto > 1)){
            splitIntoField.text = "\(splitInto! + byValue)"
        }
    }
    
    @IBAction func incrSplitButton(sender: AnyObject) {
        updateSplit(1)
        updateSplitValues()
    }
    
    @IBAction func decrSplitPressed(sender: AnyObject) {
        updateSplit(-1)
        updateSplitValues()
    }
}

