//
//  SwipeTableViewController.swift
//  ToDoList
//
//  Created by Apple on 2019/8/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else{
            return nil
            }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.updateModel(with: indexPath)
            
        }
        return [deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModel(with indexPath:IndexPath){
        
    }

}
