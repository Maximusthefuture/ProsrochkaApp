//
//  ProductListViewModel.swift
//  ProsrochkaApp
//
//  Created by Maximus on 17.03.2022.
//

import Foundation
import CoreData

class ProductListViewModel {
    
    let coreDataStack = CoreDataStack(modelName: "Overdue")
    var listOfProduct: [Product] = []
    var tagsArray = ["Meat", "Fridge"]
    
    func getProducts() -> [Product] {
        let context = coreDataStack.managedContext
        let product = Product.fetchRequest()
        let data = try! context.fetch(product)
        listOfProduct.append(contentsOf: data)
        return listOfProduct
    }
}
