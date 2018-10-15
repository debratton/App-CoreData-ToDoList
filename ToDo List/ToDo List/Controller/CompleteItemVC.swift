//
//  CompleteItemVC.swift
//  ToDo List
//
//  Created by David E Bratton on 10/14/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit
import CoreData

class CompleteItemVC: UIViewController {

    // Declare variable to hold passed value from didSelect at indexRow
    //var recievedItem = ToDo()
    var recievedItem: ToDoCoreData? = nil
    
    @IBOutlet weak var toDoItemText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Since the CoreData Item is optional, we have to unwrap
        if let toDo = recievedItem {
            if toDo.important {
                if let name = toDo.name {
                    toDoItemText.text = "❗️\(name)"
                }
            } else {
                if let name = toDo.name {
                    toDoItemText.text = "\(name)"
                }
            }
        }
    }
    
    @IBAction func completeBtnPressed(_ sender: Any) {
        // Delete from CoreData
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let itemToDelete = recievedItem {
                context.delete(itemToDelete)
            }
            // Still have to save even though we deleted
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        // Pop back to MainTVC
        navigationController?.popViewController(animated: true)
    }
    

}
