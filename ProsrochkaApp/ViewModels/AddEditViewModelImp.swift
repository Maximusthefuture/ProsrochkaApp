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
    var productQuantity: Int?
    var tags: String?
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func saveData() {
        guard let coreDataStack = coreDataStack else { return }
        let product = Product(context: coreDataStack.managedContext)
        product.name = nameProduct
        product.productDescription = productDescription
        product.quantity = Int16(productQuantity ?? 0)
        product.expiredDate = Date()
        product.image = imageData
        product.tags = transformTagsIntoArray(text: tags)
        coreDataStack.saveContext()
    }
    
    private func transformTagsIntoArray(text: String?) -> [String] {
        var array = [String]()
        let elements = text?.components(separatedBy: " ")
        array.append(contentsOf: elements!)
        return array
    }
}
