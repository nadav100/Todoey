//
//  ViewController.swift
//  Todoey
//
//  Created by Nadav Kershner on 3/11/19.
//  Copyright © 2019 Nadav Kershner. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemsArray = ["1", "2", "3"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "array") as? [String] {
            itemsArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemsArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "alert", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let textField = alert.textFields?.first, textField.text != nil {
                
                self.itemsArray.append(textField.text!)
                
                self.tableView.reloadData()
                
                self.defaults.set(self.itemsArray, forKey: "array")
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
}

