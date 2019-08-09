//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Apple on 2019/8/8.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {

    
    
    let realm = try! Realm()
    var categories:Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
    }

    // MARK: - Table View Data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].title ?? "No Category"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].backgroundColor ?? "DFDFDF")
        

        return cell
    }
    
    //MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoItem", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TodoListTableViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destination.selectedCategory = categories?[indexPath.row]
        }
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var saveTextfield = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.title = saveTextfield.text!
            newCategory.backgroundColor = UIColor.randomFlat.hexValue()
            do{
                try self.realm.write {
                    self.realm.add(newCategory)
                }
            }catch{
                print("Error saving category \(error)")
            }
            self.tableView.reloadData()

        }
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (textfield) in
            textfield.placeholder = ""
            saveTextfield = textfield
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func loadCategory(){
        categories = realm.objects(Category.self)
        tableView.reloadData()

    }
    override func updateModel(with indexPath: IndexPath) {
        if let category = categories?[indexPath.row]{
            do{
                try realm .write {
                    realm.delete(category)
                }
            }catch{
                print("Error deleting category \(error)")
            }
        }
    }
}
