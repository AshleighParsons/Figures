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
    
    let Plus = 10
    let Minus = 11
    let Multiply = 12
    let Divide = 13
    let MemoryAdd = 14
    let MemoryMinus = 15
    let Recall = 16
    
    @IBOutlet var lblTotal : UILabel!
    @IBOutlet var lblSum : UILabel!
    
    var Num1 : NSInteger = 0
    var Num2 : NSInteger = 0
    var Operand : NSInteger = 0
    var Answer : Double = 0.0
    var CurrentNumber : String = "0"
    
    var historyItems: [History] = []
    
    var EquationDone : String = ""
    var SavedAnswer : NSInteger = 0
    var MemoryNumber : NSInteger = 0
    
    func saveFirstNumber() {
//        if Operand == Recall {
//            Num1 = Int(MemoryNumber)
//            CurrentNumber = "0"
//            printNumber()
//        } else {
            Num1 = Int(CurrentNumber)!
            CurrentNumber = "0"
            printNumber()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printNumber()
    }
    
    func printNumber() {
        lblTotal.text = CurrentNumber
        lblSum.text = EquationDone
    }
    
    @IBAction func pressNumber(sender: UIButton) {
        if sender.tag >= 0 && sender.tag <= 9 {
            CurrentNumber += String(sender.tag)
            printNumber()
        }
    }
    
    @IBAction func pressOperand(sender: UIButton) {
        if sender.tag >= 10 && sender.tag <= 13 {
            Operand = sender.tag
            saveFirstNumber()
        }
        
        if sender.tag == -2 {
            CurrentNumber = "0"
            lblSum.text = ""
            printNumber()
        }
        
        if sender.tag == 16 {
            Num1 = Int(MemoryNumber)
            CurrentNumber = "0"
            printNumber()
        }
    }
    
//    @IBAction func pressMemory(sender: UIButton) {
//        if Operand == MemoryAdd {
//            MemoryNumber = SavedAnswer
//        }
//        if Operand == MemoryMinus {
//            MemoryNumber = 0
//        }
//        if Operand == Recall {
//            CurrentNumber = String(MemoryNumber)
//            printNumber()
//        }
//    }
    
    @IBAction func addMemory(_ sender: Any) {
        MemoryNumber = SavedAnswer
    }
    
    @IBAction func minusMemory(_ sender: Any) {
        MemoryNumber = 0
    }
    
    @IBAction func recallMemory(_ sender: Any) {
        CurrentNumber = String(MemoryNumber)
        printNumber()
    }
    
    @IBAction func calculate(sender: UIButton) {
        if Operand == Recall {
            Num2 = Int(MemoryNumber)
        } else {
            Num2 = Int(CurrentNumber)!
        }
        
        if Operand == Plus {
            Answer = Double(Num1 + Num2)
            EquationDone = String(Num1) + "+" + String(Num2)
            SavedAnswer = Int(Answer)
        }
        if Operand == Minus {
            Answer = Double(Num1 - Num2)
            EquationDone = String(Num1) + "-" + String(Num2)
            SavedAnswer = Int(Answer)
        }
        if Operand == Multiply {
            Answer = Double(Num1 * Num2)
            EquationDone = String(Num1) + "x" + String(Num2)
            SavedAnswer = Int(Answer)
        }
        if Operand == Divide {
            if Num2 == 0 {
                let alert = UIAlertController(title: "Whoops!", message: "We can't divide by 0 in this dimension", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                
                present(alert, animated: true)
            }
            else {
                Answer = Double(Num1) / Double(Num2)
                EquationDone = String(Num1) + "÷" + String(Num2)
                SavedAnswer = Int(Answer)
            }
        }
        
        saveAnswer(equation: EquationDone, answer: Answer)
        
        Num1 = 0
        Num2 = 0
        CurrentNumber = String(Answer)
        Operand = Plus
        printNumber()
        
        Answer = 0.0
        CurrentNumber = "0"
    }
    
//    @IBOutlet weak var lblScreen: UILabel!
//    @IBOutlet weak var lblSum: UILabel!
//
//    var numberDisplayed: Float = 0.0
//    var previousNumber: Float = 0.0
//
//    var performCalculation = false
//    var operationSymbol = ""
//    var operation = 0
//
//    var equation = ""
//    var answer: Float = 0.0
//    var answerText = ""
//
//    var historyItems: [History] = []
//
//    @IBAction func numbers(_ sender: UIButton) {
//        if performCalculation == true {
//            lblScreen.text = String(sender.tag-1)
//            numberDisplayed = Float(lblScreen.text!)!
//            performCalculation = false
//        }
//        else {
//            lblScreen.text = lblScreen.text! + String(sender.tag-1)
//            numberDisplayed = Float(lblScreen.text!)!
//        }
//    }
//
//    @IBAction func buttons(_ sender: UIButton) {
//        if lblScreen.text != "" && sender.tag != 11 && sender.tag != 18
//        {
//            previousNumber = Float(lblScreen.text!)!
//
//            if sender.tag == 12 { //square root
//                lblScreen.text = "√"
//                operationSymbol = "√"
//            }
//            else if sender.tag == 13 { // percentage
//                lblScreen.text = "%"
//                operationSymbol = "%"
//            }
//            else if sender.tag == 14 { // divide
//                lblScreen.text = "÷"
//                operationSymbol = "÷"
//            }
//            else if sender.tag == 15 { // multiply
//                lblScreen.text = "×"
//                operationSymbol = "×"
//            }
//            else if sender.tag == 16 { // minus
//                lblScreen.text = "−"
//                operationSymbol = "−"
//            }
//            else if sender.tag == 17 { // plus
//                lblScreen.text = "+"
//                operationSymbol = "+"
//            }
//            operation = sender.tag
//            performCalculation = true
//        }
//        else if sender.tag == 18 {
//            if operation == 12 {
//                answer = previousNumber.squareRoot()
////                print(answer)
//                lblScreen.text = String(format: "%0.2f", answer)
//            }
//            else if operation == 13 {
//                answer = (previousNumber / numberDisplayed) * 100
//                lblScreen.text = String(format: "%0.2f", answer)
//            }
//            else if operation == 14 {
//                answer = previousNumber / numberDisplayed
//                lblScreen.text = String(format: "%0.2f", answer)
//            }
//            else if operation == 15 {
//                answer = previousNumber * numberDisplayed
//                lblScreen.text = String(format: "%0.2f", answer)
//            }
//            else if operation == 16 {
//                answer = previousNumber - numberDisplayed
//                lblScreen.text = String(format: "%0.2f", answer)
//            }
//            else if operation == 17 {
//                answer = previousNumber + numberDisplayed
//                lblScreen.text = String(format: "%0.2f", answer)
//            }
//            lblSum.text = String(format: "%0.0f", previousNumber) + operationSymbol + String(format: "%0.0f", numberDisplayed)
//
////            answer = lblScreen.text
//        }
//        else if sender.tag == 11 {
//            lblScreen.text = ""
//            lblSum.text = ""
//            previousNumber = 0
//            numberDisplayed = 0
//            operation = 0
//        }
//
//        equation = String(lblScreen.text!)
//        answerText = String(lblSum.text!)
//
//        saveAnswer(equation: equation, answer: answerText)
//    }
    
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
    func saveAnswer(equation: String, answer: Double) {
        let history = History()

        history.equation = equation
        history.answer = answer

        historyItems.append(history)
        
//        print(historyItems[0].equation)
    }
}
