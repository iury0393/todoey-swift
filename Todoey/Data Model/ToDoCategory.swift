//
//  ToDoCategory.swift
//  Todoey
//
//  Created by Iury Vasconcelos on 02/09/22.
//

import Foundation
import RealmSwift

class ToDoCategory: Object {
    @Persisted var name: String = ""
    @Persisted var items = List<Item>()
}
