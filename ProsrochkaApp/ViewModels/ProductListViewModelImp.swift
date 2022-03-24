//
//  ProductListViewModel.swift
//  ProsrochkaApp
//
//  Created by Maximus on 17.03.2022.
//

import Foundation
import CoreData

protocol ProductListViewModel {
    func getProducts()
}

class ProductListViewModelImp: ProductListViewModel {
    
    let coreDataStack = CoreDataStack(modelName: "Overdue")
    var listOfProduct: [Product] = []
    var tagsArray: [String] = []
    
    func getProducts()  {
        let context = coreDataStack.managedContext
        let product = Product.fetchRequest()
        do {
            let data = try context.fetch(product)
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
    
    func convertData(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let data = dateFormatter.string(from: date)
        return data
    }
    
    func calculateDaysUntilExp(_ from: Date, _ exp: Date) {
        
    }
}
