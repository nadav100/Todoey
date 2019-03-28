//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nadav Kershner on 3/26/19.
//  Copyright © 2019 Nadav Kershner. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Data
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try contex.fetch(request)
        } catch  {
            print("Error fetching categories")
        }
        
        tableView.reloadData()
    }
    
    func saveCategories() {
        
        do {
            try contex.save()
        } catch {
            print("Error saving contex \(error)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "alert", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let textField = alert.textFields?.first, textField.text != nil {
                
                let newCategory = Category(context: self.contex)
                newCategory.name = textField.text!
                self.categories.append(newCategory)
                
                self.saveCategories()
                
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
}
