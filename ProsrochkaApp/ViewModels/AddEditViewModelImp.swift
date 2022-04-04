//
//  AddEditViewModel.swift
//  ProsrochkaApp
//
//  Created by Maximus on 18.03.2022.
//

import Foundation
import CoreData
import UIKit


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
        let pictureObject = ProductPicture(context: coreDataStack.managedContext)
        product.name = nameProduct
        product.productDescription = productDescription
        product.quantity = productQuantity ?? 0
        product.expiredDate = expiredDate
        product.tags = transformTagsIntoArray(text: tags)
        product.createdDate = createdDate
        pictureObject.picture = imageData
        product.imageThumbnail = imageDataScaledToHeight(imageData ?? Data(), height: 120)
        product.image = pictureObject
        
        coreDataStack.saveContext()
    }
    
    private func imageDataScaledToHeight(_ imageData: Data, height: CGFloat) -> Data? {
        let image = UIImage(data: imageData)
        guard let image = image else { return Data() }
        let oldHeight = image.size.height
        let scaleFactor = height / oldHeight
        let newWidth = image.size.width * scaleFactor
        let newSize = CGSize(width: newWidth, height: height)
        let newRect = CGRect(x: 0, y: 0, width: newWidth, height: height)
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: newRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage?.jpegData(compressionQuality: 0.8)
    }
    
    private func transformTagsIntoArray(text: String?) -> [String] {
        var array = [String]()
        let elements = text?.components(separatedBy: " ")
        array.append(contentsOf: elements!)
        return array
    }
}
