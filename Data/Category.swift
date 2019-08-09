//
//  Category.swift
//  ToDoList
//
//  Created by Apple on 2019/8/8.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
    @objc dynamic var title:String = ""
    var items = List<Item>()
}
