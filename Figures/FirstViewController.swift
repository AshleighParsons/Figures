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
                lblScreen.text = String(format: "%0.2f", previousNumber.squareRoot())
            }
            else if operation == 13 {
                lblScreen.text = String(format: "%0.2f", (previousNumber / numberDisplayed) * 100)
            }
            else if operation == 14 {
                lblScreen.text = String(format: "%0.2f", previousNumber / numberDisplayed)
            }
            else if operation == 15 {
                lblScreen.text = String(format: "%0.2f", previousNumber * numberDisplayed)
            }
            else if operation == 16 {
                lblScreen.text = String(format: "%0.2f", previousNumber - numberDisplayed)
            }
            else if operation == 17 {
                lblScreen.text = String(format: "%0.2f", previousNumber + numberDisplayed)
            }
            lblSum.text = String(format: "%0.0f", previousNumber) + operationSymbol + String(format: "%0.0f", numberDisplayed)
        }
        else if sender.tag == 11 {
            lblScreen.text = ""
            lblSum.text = ""
            previousNumber = 0
            numberDisplayed = 0
            operation = 0
        }
    }
    
    @IBAction func history(_ sender: Any) {
        viewHistory()
    }
    
    let darkView = UIView()
    
    let historyView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let hv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return hv
    }()
    
    @objc func viewHistory() {
        darkView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        view.addSubview(darkView)
        darkView.frame = view.frame
        darkView.alpha = 0
        
        view.addSubview(historyView)
        historyView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200 )
        
        UIView.animate(withDuration: 0.5, animations: { self.darkView.alpha = 1})
    }  
    
    @objc func handleDismiss() {
        self.darkView.alpha = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

