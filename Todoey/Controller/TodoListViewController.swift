//
//  ViewController.swift
//  Todoey
//
//  Created by Nadav Kershner on 3/11/19.
//  Copyright © 2019 Nadav Kershner. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var items : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            
            cell.textLabel?.text = "No items"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let item = items?[indexPath.row] {
            
            do {
                try realm.write {
                    realm.delete(item)
//                    item.done = !item.done
                }
            } catch {
                print("Error updating sone status \(error)")
            }

            
        }
        
        tableView.reloadData()
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "alert", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let textField = alert.textFields?.first, textField.text != nil {
                
                if let category = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = textField.text!
                            category.items.append(newItem)
                            
                        }
                    } catch {
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    func loadItems() {

        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
}

//extension TodoListViewController : UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        request.predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
//
//        loadItems(with: request)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//}
