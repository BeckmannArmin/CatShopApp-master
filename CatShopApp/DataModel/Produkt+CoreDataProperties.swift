//
//  Produkt+CoreDataProperties.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 28.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//
//

import Foundation
import CoreData



extension Produkt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Produkt> {
        return NSFetchRequest<Produkt>(entityName: "Produkt")
    }

    @NSManaged public var beschreibung: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var preis: Double
    @NSManaged public var kategorie: Kategorie?

}
