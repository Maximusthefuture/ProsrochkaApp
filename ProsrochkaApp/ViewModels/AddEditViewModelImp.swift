//
//  AddEditViewModel.swift
//  ProsrochkaApp
//
//  Created by Maximus on 18.03.2022.
//

import Foundation
import CoreData


protocol AddEditViewModel {
    func saveData()
   
}

class AddEditViewModelImp {

    var coreDataStack: CoreDataStack?
    var imageData: Data?
    var nameProduct: String?
    var productDescription: String?
    var productQuantity: Int16?
    var tags: String?
    var expiredDate: Date?
    var createdDate: Date?
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func saveData() {
        guard let coreDataStack = coreDataStack else { return }
        let product = Product(context: coreDataStack.managedContext)
        product.name = nameProduct
        product.productDescription = productDescription
        product.quantity = productQuantity ?? 0
        product.expiredDate = expiredDate
        product.image = imageData
        product.tags = transformTagsIntoArray(text: tags)
        product.createdDate = createdDate
        coreDataStack.saveContext()
    }
 
    private func transformTagsIntoArray(text: String?) -> [String] {
        var array = [String]()
        let elements = text?.components(separatedBy: " ")
        array.append(contentsOf: elements!)
        return array
    }
}
