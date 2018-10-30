//
//  StatsController.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

class StatsController: UITableViewController {
    @IBOutlet weak var costSegmentedControl: UISegmentedControl!
    @IBOutlet weak var measurementSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide the extra rows at the bottom
        tableView.tableFooterView = UIView()
        
        styleSegmentedControl(costSegmentedControl)
        styleSegmentedControl(measurementSegmentedControl)
    }
    
    /**
     Style a segmented control in this view controller.
     
     - Parameter control: The control to style.
    */
    private func styleSegmentedControl(_ control: UISegmentedControl) {
        control.backgroundColor = .clear
        control.tintColor = .clear
        var textAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.3)
        ]
        control.setTitleTextAttributes(textAttributes, for: .normal)
        textAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        control.setTitleTextAttributes(textAttributes, for: .selected)
    }
}
