//
//  ProductListViewModel.swift
//  ProsrochkaApp
//
//  Created by Maximus on 17.03.2022.
//

import Foundation
import CoreData

protocol ProductListViewModel {
    
}

class ProductListViewModelImp {
    
    let coreDataStack = CoreDataStack(modelName: "Overdue")
    var listOfProduct: [Product] = []
    var tagsArray: [String] = []
    
    func getProducts()  {
        let context = coreDataStack.managedContext
        let product = Product.fetchRequest()
        do {
            let data = try context.fetch(product)
            if data.count != 0 {
                if let arrayOfTags = data[0].tags {
                    tagsArray.append(contentsOf: arrayOfTags) //  ??
                }
            } else {
                tagsArray.append(contentsOf: ["Her", "Chto"]) // data[0].tags ??
            }
            
            listOfProduct.append(contentsOf: data)
        } catch let error as NSError {
            print("ERROR in productViewModel \(error)")
        }
    }
    
    func deleteAll() {
        let context = coreDataStack.managedContext
        let product = Product.fetchRequest()
        let data = try! context.fetch(product)
        for i in data {
            context.delete(i)
        }
        coreDataStack.saveContext()
    }
}
