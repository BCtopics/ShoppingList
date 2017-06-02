//
//  Item+Convenience.swift
//  ShoppingList
//
//  Created by Bradley GIlmore on 6/2/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    @discardableResult convenience init(name: String, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.name = name
        self.isComplete = isComplete
        
        //MARK: - Question 1... Why do we have to do the self.init for context, but do the self.name = name for everything else? Couldn't we just use the self.init that has all of the properties?
    }
    
}
