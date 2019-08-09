//
//  ViewController.swift
//  ToDoList
//
//  Created by Apple on 2019/7/17.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListTableViewController: UITableViewController {

    //MARK: - IBOutlet
    
    
    //MARK: - Constant
    
    let realm = try! Realm()
    var itemArray:Results<Item>?
    var selectedCategory:Category?{
        didSet{
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - TableViewDatasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        if let item = itemArray?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }

        return cell
    }
    
    
    //MARK: - TableVIewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        do{
            try realm.write {
                itemArray![indexPath.row].done = !itemArray![indexPath.row].done
            }
        }catch{
            print("Error saving item \(error)")
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // Add New item Method
    @IBAction func addButtonPressed(sender:UIBarButtonItem){
        var saveTextfield = UITextField()
        let addAlert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let saveTextfield = saveTextfield.text{
                
                let newItem = Item()
                newItem.title = saveTextfield
                newItem.done = false
                do{
                    try self.realm.write {
                    self.selectedCategory?.items.append(newItem)
                    }
                }catch{
                    print("Error saving item \(error)")
                }
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
    
    // MARK: - Model Manupulation Methods
    func saveItems(){

        
    }
    func loadItems(){
        itemArray = realm.objects(Item.self)
        tableView.reloadData()
        
    }

}


extension TodoListTableViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            itemArray = realm.objects(Item.self)
            
            tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
