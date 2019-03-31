//
//  Item.swift
//  Todoey
//
//  Created by Nadav Kershner on 3/28/19.
//  Copyright © 2019 Nadav Kershner. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
