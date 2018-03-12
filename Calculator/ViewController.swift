//
//  ViewController.swift
//  Calculator
//
//  Created by Chi Nguyen on 3/9/18.
//  Copyright © 2018 Chi Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var ACButton: UIButton!
    var num1: Float = 0
    var num2: Float  = 0
    var result: Float = 0
    var op = ""
    var newNum = true
    var dot = false
    var State = 0
    var eq = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button0(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button1(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button2(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button3(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button4(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button5(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button6(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button7(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button8(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button9(_ sender: UIButton) {
        numAction(sender: sender)
    }
    @IBAction func button_dot(_ sender: UIButton) {
        if (!dot && !newNum) {
            displayLabel.text = displayLabel.text! + "."
            dot = true
        } else if !dot && newNum {
            displayLabel.text = "0."
            dot = true
            newNum = false
        }
    }
    @IBAction func button_add(_ sender: UIButton) {
        opAction(sender: sender)
    }
    @IBAction func button_sub(_ sender: UIButton) {
       opAction(sender: sender)
    }
    @IBAction func button_mult(_ sender: UIButton) {
        opAction(sender: sender)
    }
    @IBAction func button_div(_ sender: UIButton) {
        opAction(sender: sender)
    }
    @IBAction func button_per(_ sender: UIButton) {
        num1 = num1/100
        if num1.truncatingRemainder(dividingBy: 1) == 0 {
            displayLabel.text = String(Int(num1))
        } else {
            displayLabel.text = String(num1)
        }
    }
    @IBAction func button_neg(_ sender: UIButton) {
        num1 = 0 - num1
        if num1.truncatingRemainder(dividingBy: 1) == 0 {
            displayLabel.text = String(Int(num1))
        } else {
            displayLabel.text = String(num1)
        }
    }
    @IBAction func button_eq(_ sender: UIButton) {
        eqAction()
    }
    
    @IBAction func button_AC (_ sender: UIButton) {
        // if label is already, reset to initial state
        // else set label to AC modify state
//        print("AC pressed -------")
//        printStat()
//
        // setting displayLabel
        if State == 0 || State == 1 || State == 5 {
            displayLabel.text = "0"
        } else if State == 2 {
            if num1.truncatingRemainder(dividingBy: 1) == 0 {
                displayLabel.text = String(Int(num1))
            } else {
                displayLabel.text = String(num1)
            }
        } else if State == 3 {
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                displayLabel.text = String(Int(result))
            } else {
                displayLabel.text = String(result)
            }
        } else if State == 4 {
            displayLabel.text = "0"
            num2 = 0
        }
        
        // set label of button and state
        if (ACButton.titleLabel?.text)! == "AC" {
            reset()
        } else {
            ACButton.setTitle("AC", for: .normal)
            if State == 0 || State == 1 {
                State = 0
            } else {
                State = 2
            }
        }
//        print("----")
//        printStat()
//        print("AC exit ~~~~~~~~~~~")
    }
    
    func numAction(sender: UIButton) {
//        print("number entered -----------")
//        printStat()
        if State == 0 {
            State = 1
            newNum = false
            showDisplay(val: Float(sender.tag))
            num1 = Float(displayLabel.text!)!
        } else if State == 1 {
            showDisplay(val: Float(sender.tag))
            num1 = Float(displayLabel.text!)!
        } else if State == 2 {
            State = 3
            showDisplay(val: Float(sender.tag))
            num2 = Float(displayLabel.text!)!
        } else if State == 3 {
            showDisplay(val: Float(sender.tag))
            num2 = Float(displayLabel.text!)!
        } else if State == 4 {
            State = 5
            newNum = true
            showDisplay(val: Float(sender.tag))
            num1 = Float(displayLabel.text!)!
        } else if State == 5 {
            showDisplay(val: Float(sender.tag))
            num1 = Float(displayLabel.text!)!
        }
        ACButton.setTitle("C", for: .normal)
        
//        print("----")
//        printStat()
//        print("exit number -----------")
    }
    
    func opAction(sender: UIButton) {
//        print("op entered -----------")
        newNum = true
        if State == 0 {
            State = 2
        } else if State == 1 {
            State = 2
        } else if State == 3 {
            State = 4
            calculate()
            showDisplay(val: result)
            num1 = Float(displayLabel.text!)!
        } else if State == 4 {
            State = 3
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                displayLabel.text = String(Int(result))
            } else {
                displayLabel.text = String(result)
            }
        } else if State == 5 {
            State = 1
            num1 = Float(displayLabel.text!)!
        }
        op = (sender.titleLabel?.text)!
 
//        printStat()
//        print("op exit -----------")

    }
    
    func eqAction() {
//        print("eq entered -----------")
        newNum = true
        eq = true
        if State == 2 {
            State = 4
            calculate()
            showDisplay(val: result)
            num2 = num1
            num1 = result
        } else if State == 3 {
            State = 4
            calculate()
            showDisplay(val: result)
            num1 = result
        } else if State == 4 || State == 5 {
            State = 4
            calculate()
            showDisplay(val: result)
            num1 = result
        }
//
//        printStat()
//        print("eq exit -----------")

    }
    
    func showDisplay (val: Float) {
//        print("show -----------")
        var val1: String
        if val.truncatingRemainder(dividingBy: 1) == 0 {
            val1 = String(Int(val))
        } else {
            val1 = String(val)
        }
        
        if (newNum) {
            displayLabel.text = val1
            newNum = false
        } else {
            if displayLabel.text == "0" {
                displayLabel.text = val1
            } else {
                displayLabel.text = displayLabel.text! + val1
            }
        }
//        printStat()
//        print("show exit -----------")
    }
    
    func calculate() {
        // perform num1 op num2
        // set display text = result
        // set num1 to result
        
//        print("calculate ++++++++")
        
        if op == "+" {
            result = num1 + num2
        } else if op == "-" {
            result = num1 - num2
        } else if op == "x" {
            result = num1 * num2
        } else if op == "/" {
            result = num1 / num2
        }
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            displayLabel.text = String(Int(result))
        } else {
            displayLabel.text = String(result)
        }
        num1 = result
//          printStat()
//        print("++++++++")

    }
    
    func printStat() {
        print("num1: ", self.num1)
        print("num2: ", self.num2)
        print("res: ", self.result)
        print("op: ", self.op)
        print("newNum: ", newNum)
        print("dot: ", dot)
        print("State: ", State)
        print("eq: ", eq)
        print("display: ", displayLabel.text!)

    }
    
    func reset() {
        State = 0
        eq = false
        dot = false
        num1 = 0
        num2 = 0
        result = 0
        op = ""
        newNum = true
    }
    
}

