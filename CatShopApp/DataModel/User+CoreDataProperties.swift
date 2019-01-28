//
//  User+CoreDataProperties.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 27.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    
    @NSManaged public var vorname: String?
    @NSManaged public var nachname: String?
    @NSManaged public var email: String?
    @NSManaged public var strasse: String?
    @NSManaged public var hausnummer: String?
    @NSManaged public var plz: String?
    @NSManaged public var stadt: String?
    @NSManaged public var password: String?

}
