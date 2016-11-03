//
//  ViewController.swift
//  3nPlus1Problem
//
//  Created on: 04-May-2016
//      Author: Nafisa Rahman
//
//  LICENSE:-
//  The MIT License (MIT)
//  Copyright (c) 2016 Nafisa Rahman
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom
//  the Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall
//  be included in all copies or substantial portions of the
//  Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
//  OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    //MARK:- properties
    @IBOutlet weak var firstNumLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    //MARK:- methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //MARK: set textfield delegate
        firstTextField.delegate = self
        secondTextField.delegate = self
        
        
        //MARK: tap outside to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //dismiss keyboard when tapped outside
    func hideKeyboard() {
        
        view.endEditing(true)
        
    }
    
    //MARK:- Iterative computation of  max cycle length
    @IBAction func displayIterative(_ sender: UIButton) {
        
        compute(false)
        
    }
    
    //MARK:- clears text fields and result label
    @IBAction func clear(_ sender: UIButton) {
        
        //first text field
        firstTextField.text = ""
        firstTextField.placeholder = "Enter a number"
        
        //second text field
        secondTextField.text = ""
        secondTextField.placeholder = "Enter a number"
        
        //result label
        resultLabel.text = "Result"
        
    }
    
    
    //MARK: recursive computation of  max cycle length
    @IBAction func display(_ sender: UIButton) {
        
        compute(true)
    }
    
    //MARK:- compute and display max cycle length
    func compute(_ flag : Bool){
        
        //first textfield is empty - show alert
        if firstTextField.placeholder == "Enter a number"  {
            
            showAlert("First Input number is empty",msg: "Enter a number")
        }
            
            //second textfield is empty - show
        else if secondTextField.placeholder == "Enter a number" {
            showAlert("Second Input number is empty",msg: "Enter a number")
            
        }
            
        else {
            
            //first text field user input is not null
            guard let userInput1 = firstTextField.text else {
                return
            }
            
            //second text field user input is not null
            guard let userInput2 = secondTextField.text else {
                return
            }
            
            //convert first text field user input to integer
            guard let firstNum = Int(userInput1) else {
                return
            }
            
            //convert second text field user input to integer
            guard let secondNum = Int(userInput2) else {
                return
            }
            
            //start time
            let startTime = Date()
            
            
            //instance of MaxCycle class
            let cycle = MaxCycle(num1: firstNum, num2: secondNum)
            
            //computation type
            cycle.recursive = flag
            
            //end time
            let endTime = Date()
            
            
            //calculate time interval in seconds
            let computationTime = NSDecimalNumber(value: endTime.timeIntervalSince(startTime) as Double)
            
            
            var labelText = ""
            var calculationSteps = ""
            
            labelText = "Result " + "\n" + "Max CycleLength = \(cycle.inputPair())" +
                "\n" + "Computation Time = \(computationTime) Seconds"
            
            for step in cycle.calculationSteps {
                
                calculationSteps = "Input Number : " + "\(step.inputNumber)" + "\n" +
                    "Stopping Number : " + "\(step.stoppingNumber)" + "\n" +
                    "Cycle Length : "  + "\(step.cycle)"
                
                print(calculationSteps)
                print("----------")
            }
            
            //remove calculation
            cycle.calculationSteps.removeAll()
            
            resultLabel.text = labelText
        }
        
    }
    
    //MARK:- show alert for invalid no
    func showAlert(_ desc: String,msg: String) {
        
        let alert = UIAlertController(title: desc,
                                      message: msg,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- textfield
    
    //if textview empty after user editing show placeholder empty
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text!.isEmpty {
            textField.placeholder = "Enter a number"
            textField.textColor = UIColor.lightGray
        }
    }
    
    
    //remove placeholder text
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.placeholder = nil
    }
    
    //return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    //text view validation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let validCharacters = CharacterSet(charactersIn: "0123456789")
        let inputRange = string.characters.indices
        
        
        //if entered char is present in  valid character set then returns a valid range
        if  (string.rangeOfCharacter(from: validCharacters, options: [], range: inputRange) == nil) {
            
            //invalid char thus don't change the text field string
            return false
        } else {
            
            //text field string should be changed to accomodate the newly entered valid char
            return true
        }
    }
}
