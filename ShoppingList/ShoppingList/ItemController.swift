//
//  ItemController.swift
//  ShoppingList
//
//  Created by Bradley GIlmore on 6/2/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    //MARK: - Shared Instance
    
    static let shared = ItemController()
    
    //MARK: - Create, Update, Delete, Toggle, Save, Fetch
    
    // Create
    func createNewItemWith(name: String, isComplete: Bool = false) {
        _ = Item(name: name, isComplete: isComplete)
        saveToPersistentStore()
    }
    
    // Update
    func update(item: Item, name: String, isComplete: Bool) {
        item.name = name
        item.isComplete = isComplete
        saveToPersistentStore()
    }
    
    // Delete
    func deleteItem(item: Item){
        CoreDataStack.context.delete(item)
        saveToPersistentStore()
    }
    
    // Toggle
    func toggleIsCompleteFor(item: Item) {
        item.isComplete = !item.isComplete
        saveToPersistentStore()
    }

    // Save
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch {
            NSLog("Save to persistent store has failed error: \(error)")
        }
    }
    
    // Fetch Request 
    func fetchTasks() -> [Item] {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true )
        fetchRequest.sortDescriptors = [ sortDescriptor ]
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
            
        } catch {
            NSLog("Failed fetch request \(error)")
            return []
        }
    }

    
}
