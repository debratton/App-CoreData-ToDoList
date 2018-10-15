//
//  MainTVC.swift
//  ToDo List
//
//  Created by David E Bratton on 10/14/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit
import CoreData

class MainTVC: UITableViewController {

    // Change Array to point to Core Data
    var toDosCD = [ToDoCoreData]()
    
    // ARRAY before Core Data
    //Two styles, same thing 2nd is shorter
    //var toDos: [ToDo] = []
    //var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Store some test data in array for testing at beginning
        /*
        let toDo1 = ToDo()
        toDo1.name = "Walk the dogs"
        toDo1.important = false
        
        let toDo2 = ToDo()
        toDo2.name = "Take out the garbage"
        toDo2.important = true
        
        let toDo3 = ToDo()
        toDo3.name = "Watch the Bears game"
        toDo3.important = false
        
        let toDo4 = ToDo()
        toDo4.name = "Check on Trouble stone"
        toDo4.important = true
        
        toDos = [toDo1, toDo2, toDo3, toDo4]
        */

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDosFromCoreData()
    }
    
    func getToDosFromCoreData() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreDate = try? context.fetch(ToDoCoreData.fetchRequest()) {
                if let toDos = toDosFromCoreDate as? [ToDoCoreData] {
                    toDosCD = toDos
                    tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Core Data
        return toDosCD.count
        
        // No Core Data
        //return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        //cell.textLabel?.text = toDos[indexPath.row].name
        
        let cell = UITableViewCell()
        // With Core Data
        let currentToDo = toDosCD[indexPath.row]
        
        // No Core Data
        //let currentToDo = toDos[indexPath.row]
        
        if currentToDo.important {
            if let name = currentToDo.name {
                cell.textLabel?.text = "❗️\(name)"
            }
            // !
            // Two ways to right out
            //cell.textLabel?.text = "!" + currentToDo.name
            // To get EMOJI control + command + space bar
            //cell.textLabel?.text = "❗️ \(currentToDo.name)"
        } else {
            // Normal
            cell.textLabel?.text = currentToDo.name
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // With Core Data
        let selectedItem = toDosCD[indexPath.row]
        
        // Without Core Data
        //let selectedItem = toDos[indexPath.row]
        performSegue(withIdentifier: "goToCompleteItem", sender: selectedItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddItemVC {
            // addItem Declared in AddItem to store value to pass back here
            // Sending the whole object structure, not value
            addVC.addItem = self
        }
        
        if let completeVC = segue.destination as? CompleteItemVC {
            // Pass selected item from tableview
            // Requires func didSelectRowAt and identifier
            // Passing the actual value
            if let passedItem = sender as? ToDoCoreData {
                completeVC.recievedItem = passedItem
            }
        }
    }
}
