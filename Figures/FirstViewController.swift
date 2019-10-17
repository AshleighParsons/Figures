//
//  FirstViewController.swift
//  Figures
//
//  Created by Ashleigh Parsons on 2019/10/10.
//  Copyright © 2019 Ashleigh Parsons. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    //CALCULATOR FUNCTIONALITY
    
    @IBOutlet weak var lblScreen: UILabel!
    @IBOutlet weak var lblSum: UILabel!
    
    var numberDisplayed: Float = 0.0
    var previousNumber: Float = 0.0
    
    var performCalculation = false
    var operationSymbol = ""
    var operation = 0
    
    var equation = ""
    var answer: Float = 0.0
    
    var historyItems: [History] = []
    
    @IBAction func numbers(_ sender: UIButton) {
        if performCalculation == true {
            lblScreen.text = String(sender.tag-1)
            numberDisplayed = Float(lblScreen.text!)!
            performCalculation = false
        }
        else {
            lblScreen.text = lblScreen.text! + String(sender.tag-1)
            numberDisplayed = Float(lblScreen.text!)!
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if lblScreen.text != "" && sender.tag != 11 && sender.tag != 18
        {
            previousNumber = Float(lblScreen.text!)!
            
            if sender.tag == 12 { //square root
                lblScreen.text = "√"
                operationSymbol = "√"
            }
            else if sender.tag == 13 { // percentage
                lblScreen.text = "%"
                operationSymbol = "%"
            }
            else if sender.tag == 14 { // divide
                lblScreen.text = "÷"
                operationSymbol = "÷"
            }
            else if sender.tag == 15 { // multiply
                lblScreen.text = "×"
                operationSymbol = "×"
            }
            else if sender.tag == 16 { // minus
                lblScreen.text = "−"
                operationSymbol = "−"
            }
            else if sender.tag == 17 { // plus
                lblScreen.text = "+"
                operationSymbol = "+"
            }
            operation = sender.tag
            performCalculation = true
        }
        else if sender.tag == 18 {
            if operation == 12 {
                answer = previousNumber.squareRoot()
//                print(answer)
                lblScreen.text = String(format: "%0.2f", answer)
            }
            else if operation == 13 {
                answer = (previousNumber / numberDisplayed) * 100
                lblScreen.text = String(format: "%0.2f", answer)
            }
            else if operation == 14 {
                answer = previousNumber / numberDisplayed
                lblScreen.text = String(format: "%0.2f", answer)
            }
            else if operation == 15 {
                answer = previousNumber * numberDisplayed
                lblScreen.text = String(format: "%0.2f", answer)
            }
            else if operation == 16 {
                answer = previousNumber - numberDisplayed
                lblScreen.text = String(format: "%0.2f", answer)
            }
            else if operation == 17 {
                answer = previousNumber + numberDisplayed
                lblScreen.text = String(format: "%0.2f", answer)
            }
            lblSum.text = String(format: "%0.0f", previousNumber) + operationSymbol + String(format: "%0.0f", numberDisplayed)
            
//            answer = lblScreen.text
        }
        else if sender.tag == 11 {
            lblScreen.text = ""
            lblSum.text = ""
            previousNumber = 0
            numberDisplayed = 0
            operation = 0
        }

        equation = String(format: "%0.0f", previousNumber) + operationSymbol + String(format: "%0.0f", numberDisplayed)
        saveAnswer(equation: equation, answer: answer)
    }
    
    @IBAction func onHistoryTab(_ sender: Any) {
        performSegue(withIdentifier: "toHistory", sender: nil)
    } 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SecondViewController {
            let viewController = segue.destination as? SecondViewController
            viewController?.historyItems = self.historyItems
        }
    }
}


extension FirstViewController {
    func saveAnswer(equation: String, answer: Float) {
        let history = History()

        history.equation = equation
        history.answer = answer

        historyItems.append(history)
        
//        print(historyItems[0].equation)
    }
}
