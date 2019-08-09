//
//  Item.swift
//  ToDoList
//
//  Created by Apple on 2019/8/8.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import RealmSwift

class Item:Object{
    @objc dynamic var title:String = ""
    @objc dynamic var done:Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
