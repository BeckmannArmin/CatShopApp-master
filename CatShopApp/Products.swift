//
//  Products.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 30.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Products: NSObject {
    
    var name: String! = ""
    var preis: Double! = 0
    var image: UIImage?
    var beschreibung: String! = ""
    var uid: String!
    
    override init() {
    }
    
    init(name: String, preis: Double, image: UIImage, beschreibung: String, uid: String){
        self.name = name
        self.preis = preis
        self.image = image
        self.beschreibung = beschreibung
        self.uid = uid
    }
    
    init(name: String, preis: Double, beschreibung: String, uid: String) {
        self.name = name
        self.preis = preis
        self.beschreibung = beschreibung
        self.uid = uid
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let otherProduct = object as? Products {
            if self.name == otherProduct.name && self.preis == otherProduct.preis && self.image == otherProduct.image && self.beschreibung == otherProduct.beschreibung && self.uid == otherProduct.uid {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}
