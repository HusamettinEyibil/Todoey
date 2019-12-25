//
//  ViewController.swift
//  Todoey
//
//  Created by Hüsamettin  Eyibil on 20.12.2019.
//  Copyright © 2019 Hüsamettin  Eyibil. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [ItemCellModel]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = ItemCellModel()
        item1.title = "Find Mike"
        itemArray.append(item1)
        
        let item2 = ItemCellModel()
        item2.title = "Find Joe"
        itemArray.append(item2)
        
        let item3 = ItemCellModel()
        item3.title = "Find Alice"
        itemArray.append(item3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [ItemCellModel] {
            itemArray = items
        }
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .blue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                let item = ItemCellModel()
                item.title = textField.text!
                self.itemArray.append(item)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}

