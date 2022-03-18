//
//  AddEditViewModel.swift
//  ProsrochkaApp
//
//  Created by Maximus on 18.03.2022.
//

import Foundation
import CoreData

class AddEditViewModel {
    var coreDataStack: CoreDataStack?
    
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func saveData() {
        guard let coreDataStack = coreDataStack else { return }
        let product = Product(context: coreDataStack.managedContext)
        product.name = "Test name \(product.objectID)"
        product.productDescription = "Some description"
        product.expiredDate = Date()
        product.tags = ["Chinken", "Refrigerator"]
        
        coreDataStack.saveContext()
    }
}
