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
    
    var itemArray = ["1","2","3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - TableViewDatasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    //MARK: - TableVIewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
            }else{
                cell.accessoryType = .checkmark
            }
        }
    }
    // Add New item Method
    @IBAction func addButtonPressed(sender:UIBarButtonItem){
        var saveTextfield = UITextField()
        let addAlert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let saveTextfield = saveTextfield.text{
                self.itemArray.append(saveTextfield)
                self.tableView.reloadData()
            }
        }
        addAlert.addTextField { (textfield) in
            textfield.placeholder = "Create New Item"
            saveTextfield = textfield
        }
        addAlert.addAction(addAction)
        present(addAlert, animated: true, completion: nil)
    }

}

