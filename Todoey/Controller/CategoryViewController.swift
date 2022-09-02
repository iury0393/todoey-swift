//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Iury Vasconcelos on 30/08/22.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories = [ToDoCategory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = category.name
        
        cell.contentConfiguration = content
        return cell
        
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: ToDoCategory) {
        
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error fetching context: \(error)")
//        }
//        tableView.reloadData()
    }
    
    //MARK: - View Methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            
            let newCategory = ToDoCategory()
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
