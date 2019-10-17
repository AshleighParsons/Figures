//
//  SecondViewController.swift
//  Figures
//
//  Created by Ashleigh Parsons on 2019/10/10.
//  Copyright © 2019 Ashleigh Parsons. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let identifier = "cell"
    var historyItems: [History] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.reloadData()
    }
    
    
    @IBAction func onDoneTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        historyItems.removeAll()
        tableView.reloadData()
        
        if let viewController = self.presentingViewController as? SecondViewController {
            DispatchQueue.main.async {
                viewController.historyItems.removeAll()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        let equation = historyItems[indexPath.row]
        cell.textLabel?.text = String(format:"%.1f", equation.answer ?? 0.0)
        cell.detailTextLabel?.text = equation.equation

        return cell
    }
}
