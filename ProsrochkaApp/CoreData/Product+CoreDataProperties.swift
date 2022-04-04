//
//  Product+CoreDataProperties.swift
//  ProsrochkaApp
//
//  Created by Maximus on 18.03.2022.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var expiredDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var tags: [String]?
    @NSManaged public var imageThumbnail: Data?
    @NSManaged public var image: ProductPicture?

    
}
