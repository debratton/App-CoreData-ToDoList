//
//  AddItemVC.swift
//  ToDo List
//
//  Created by David E Bratton on 10/14/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit
import CoreData

class AddItemVC: UIViewController {

    @IBOutlet weak var itemTxt: UITextField!
    @IBOutlet weak var importantSwitchBtn: UISwitch!
    @IBOutlet weak var addBtn: UIButton!
    
    // Hold toDos object pass back to MainTVC
    // Blank object to hold value to pass back
    var addItem: MainTVC? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBtn.isEnabled = false
    }
    
    // Create on text change to enable / disable add button
    // Sender has to be UITextField get error with default Any
    @IBAction func itemTxtChanged(_ sender: UITextField) {
        if sender.text != "" {
            addBtn.isEnabled = true
        } else {
            addBtn.isEnabled = false
        }
    }
    
    
    @IBAction func addItemBtnPressed(_ sender: Any) {
        // CORE DATA
        // Once you get the context, almost exactly like just using the class file
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newToDo = ToDoCoreData(context: context)
            // Copied and pasted from code without core data
            newToDo.important = importantSwitchBtn.isOn
            if let item = itemTxt.text {
                newToDo.name = item
            }
            // Save the data to CoreData
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
        // OLD Code for object class without core data
        /*
        let newToDo = ToDo()
        newToDo.important = importantSwitchBtn.isOn
        if let item = itemTxt.text {
            newToDo.name = item
        }
        // Append new item to array on MainTVC
        addItem?.toDos.append(newToDo)
        // Now we have to refresh the table otherwise the new item in array will not show
        addItem?.tableView.reloadData()
        
        // Instead of having to hit the back button and have user go back after hitting Add
        navigationController?.popViewController(animated: true)
 */
    }
    

}
