//
//  Kategorie+CoreDataProperties.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 28.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//
//

import Foundation
import CoreData


extension Kategorie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kategorie> {
        return NSFetchRequest<Kategorie>(entityName: "Kategorie")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var produkte: NSSet?

}

// MARK: Generated accessors for produkte
extension Kategorie {

    @objc(addProdukteObject:)
    @NSManaged public func addToProdukte(_ value: Produkt)

    @objc(removeProdukteObject:)
    @NSManaged public func removeFromProdukte(_ value: Produkt)

    @objc(addProdukte:)
    @NSManaged public func addToProdukte(_ values: NSSet)

    @objc(removeProdukte:)
    @NSManaged public func removeFromProdukte(_ values: NSSet)

}
