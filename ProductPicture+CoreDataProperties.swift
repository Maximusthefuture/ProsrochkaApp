//
//  ProductPicture+CoreDataProperties.swift
//  ProsrochkaApp
//
//  Created by Maximus on 04.04.2022.
//
//

import Foundation
import CoreData


extension ProductPicture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductPicture> {
        return NSFetchRequest<ProductPicture>(entityName: "ProductPicture")
    }

    @NSManaged public var picture: Data?
    @NSManaged public var product: Product?

}
