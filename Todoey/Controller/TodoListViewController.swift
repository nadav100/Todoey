//
//  ViewController.swift
//  Todoey
//
//  Created by Nadav Kershner on 3/11/19.
//  Copyright © 2019 Nadav Kershner. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemsArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "array") as? [Item] {
            itemsArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = itemsArray[indexPath.row]
        item.done = !item.done
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "alert", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let textField = alert.textFields?.first, textField.text != nil {
                
                let newItem = Item()
                newItem.title = textField.text!
                self.itemsArray.append(newItem)
                
                self.tableView.reloadData()
                
//                self.defaults.set(self.itemsArray, forKey: "array")
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
}

