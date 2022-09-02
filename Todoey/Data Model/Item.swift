//
//  Item.swift
//  Todoey
//
//  Created by Iury Vasconcelos on 02/09/22.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    @Persisted(originProperty: "items") var parentCategory: LinkingObjects<ToDoCategory>
}
