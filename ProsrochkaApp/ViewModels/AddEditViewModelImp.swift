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
        
        let calendar = Calendar.current
        
       var date = expiredDate
        var isNotificationOn: Bool?
        if let isNotificationOn = isNotificationOn {
            if isNotificationOn {
//                NotificationManager.shared.scheduleNotification(time: scheduledTime, dailyTask: dailyItem)
                let newDate = addDaysToDate(daysCount: -3, date: date!)
            }
        }
    }
    
    private func addDaysToDate(daysCount: Int, date: Date) -> Date? {
        let calendar = Calendar.current
        let scheduledTime = calendar.date(byAdding: .day, value: -3, to: date)
        return scheduledTime
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
        if let elements = elements {
            array.append(contentsOf: elements)
        }
        return array
    }
}
