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
    var CurrentNumber : String = ""
    
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
            CurrentNumber = ""
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
        sender.pulsate()
        if sender.tag >= 0 && sender.tag <= 9 {
            CurrentNumber += String(sender.tag)
            printNumber()
        }
    }
    
    @IBAction func pressOperand(sender: UIButton) {
        sender.pulsate()
        if sender.tag >= 10 && sender.tag <= 13 {
            Operand = sender.tag
            saveFirstNumber()
        }
        
        if sender.tag == -2 {
            CurrentNumber = ""
            EquationDone = ""
            lblSum.text = ""
            printNumber()
        }
        
        if sender.tag == 16 {
            Num1 = Int(MemoryNumber)
            CurrentNumber = ""
            printNumber()
        }
    }
    
    @IBAction func addMemory(_ sender: UIButton) {
        sender.pulsate()
        MemoryNumber = SavedAnswer
    }
    
    @IBAction func minusMemory(_ sender: UIButton) {
        sender.pulsate()
        MemoryNumber = 0
    }
    
    @IBAction func recallMemory(_ sender: UIButton) {
        sender.pulsate()
        CurrentNumber = String(MemoryNumber)
        printNumber()
    }
    
    @IBAction func calculate(sender: UIButton) {
        sender.pulsate()
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
        CurrentNumber = String(format: "%.2f", Answer)
        Operand = Plus
        printNumber()
        
        Answer = 0.0
        CurrentNumber = ""
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        clearCalc()
    }
    
    func clearCalc() {
        Num1 = 0
        Num2 = 0
        Answer = 0.0
        CurrentNumber = ""
        EquationDone = ""
        lblSum.text = ""
        printNumber()
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
    func saveAnswer(equation: String, answer: Double) {
        let history = History()

        history.equation = equation
        history.answer = answer

        historyItems.append(history)
        
//        print(historyItems[0].equation)
    }
}
