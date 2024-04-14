//
//  Product+CoreDataProperties.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 13/04/24.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: Int16
    @NSManaged public var price: Double
    @NSManaged public var rating: Double
    @NSManaged public var title: String?
    @NSManaged public var imageString: String?
    @NSManaged public var thumbnail: String?

}

extension Product : Identifiable {

}
