//
//  ViewController.swift
//  ToDoList
//
//  Created by Apple on 2019/7/17.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    //MARK: - IBOutlet
    
    
    //MARK: - Constant
    
    var itemArray:[Item] = []
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
        
    }
    
    //MARK: - TableViewDatasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.isCheckMarked ? .checkmark : .none
        return cell
    }
    
    
    //MARK: - TableVIewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        itemArray[indexPath.row].isCheckMarked = !itemArray[indexPath.row].isCheckMarked
        saveItems()
    }
    // Add New item Method
    @IBAction func addButtonPressed(sender:UIBarButtonItem){
        var saveTextfield = UITextField()
        let addAlert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let saveTextfield = saveTextfield.text{
                
                let newItem = Item()
                newItem.title = saveTextfield
                self.itemArray.append(newItem)
                self.saveItems()
            }
        }
        addAlert.addTextField { (textfield) in
            textfield.placeholder = "Create New Item"
            saveTextfield = textfield
        }
        addAlert.addAction(addAction)
        present(addAlert, animated: true, completion: nil)
    }
    
    // MARK: - Model Manupulation Methods
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        tableView.reloadData()
        
    }
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
                
            }
        }
        
    }

}

