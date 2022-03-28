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
    
    
  
    
    func calculateTotalDaysUntilExp(_ from: Date?, _ exp: Date?) -> String {
        let calendar = Calendar.current
        let days = calendar.numberOfDaysBeetween(from ?? Date(), and: exp ?? Date())
        return  "\(days)"
//        let formatter = DateComponentsFormatter()
//        formatter.unitsStyle = .full
//        formatter.allowedUnits = [.year, .month, .day]
//        let interval = from?.timeIntervalSince(exp!)
//        if let interval = interval {
//            let finalDate = formatter.string(from: interval)
//            //y, mo, w, d
////            print("INTERVAL", finalDate)
//            if let splittedInterval = finalDate?.components(separatedBy: " ") {
//                print("splitted intervals", splittedInterval)
//                for i in splittedInterval {
//
////                    print("INTERVAL ARRAY", i)
//                }
//
//                return finalDate!
//            }
//
//        }
//        return ""
        
    }
}

extension Calendar {
    func numberOfDaysBeetween(_ from: Date, and to: Date) -> Int {
        let numbersOfDays = dateComponents([.day], from: from, to: to)
        return numbersOfDays.day!
    }
}
