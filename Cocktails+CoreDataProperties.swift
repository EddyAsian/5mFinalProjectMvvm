//
//  Cocktails+CoreDataProperties.swift
//  CoctailsApp
//
//  Created by Eldar on 24/2/23.
//
//

import UIKit
import CoreData


extension Cocktails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cocktails> {
        return NSFetchRequest<Cocktails>(entityName: "Cocktails")
    }

    @NSManaged public var dateAdded: Date?
    @NSManaged public var ratingNumber: String?
    @NSManaged public var cocktailsDescription: String?
    @NSManaged public var cocktailsName: String?
    @NSManaged public var cocktailsImage: String?
    @NSManaged public var cocktailsModel: Data?

}

extension Cocktails : Identifiable {

}
