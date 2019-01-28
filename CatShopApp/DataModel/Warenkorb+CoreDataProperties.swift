//
//  Warenkorb+CoreDataProperties.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 27.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//
//

import Foundation
import CoreData



extension Warenkorb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Warenkorb> {
        return NSFetchRequest<Warenkorb>(entityName: "Warenkorb")
    }

    @NSManaged public var menge: Double
    @NSManaged public var user: User?

}
