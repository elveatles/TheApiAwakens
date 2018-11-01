//
//  ResourcePickerDataSource.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Provides data for a picker view that shows Star Wars resources such as people, starships, and vehicles
class ResourcePickerDataSource: NSObject, UIPickerViewDataSource {
    var data = [Resource]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}
