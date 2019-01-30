//
//  Model.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 29.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit
import CoreData

class Model: NSObject{
    
    var products = [Products]()
    var storedProducts = [NSManagedObject]()
    
    var cart = [[Double]]()
    var storedCart = [NSManagedObject]()

    override init() {
        
        super.init()
        
        self.loadProducts()
        self.loadCart()
    }
    
    func loadProducts() {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Produkt")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            storedProducts = results as! [NSManagedObject]
            
            if storedProducts.count > 0 {
                for index in 0...storedProducts.count - 1 {
                    
                    let name = storedProducts[index].value(forKey: "name") as! String
                    let preis = storedProducts[index].value(forKey: "preis") as! Double
                    let beschreibung = storedProducts[index].value(forKey: "beschreibung") as! String
//                    let imageData = storedProducts[index].value(forKey: "image") as! Data
//                    let image = UIImage(data: imageData)
                    let uid = storedProducts[index].value(forKey: "uid") as! String
                    
                    
                    let loadedProduct = Products(name:name,preis:preis,beschreibung:beschreibung,uid:uid)
                    
                    products.append(loadedProduct)
    
                }
            }
        }
        catch let error as NSError
        {
            print("Could not load. \(error), \(error.userInfo)")
        }
    }
    
    func loadCart() {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Warenkorb")
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            storedCart = results as! [NSManagedObject]
            
            if storedCart.count > 0 {
                for index in 0...storedCart.count - 1 {
                    let menge = storedCart[index].value(forKey: "menge") as! Double
                    let produkt = storedCart[index].value(forKey: "produkt") as! Double
                    let total = storedCart[index].value(forKey: "total") as! Double
                    
                    let temp = [menge,produkt,total]
                    cart.append(temp)
                    
                }
            }
        }
        catch let error as NSError
        {
            print("Could not load. \(error), \(error.userInfo)")
        }
        
    }
    
    func checkForProduct(_ searchItem: Products) -> Int {
        var targetIndex = -1
        
        if products.count > 0 {
            for index in 0...products.count - 1 {
                if products[index].uid == searchItem.uid {
                    targetIndex = index
                }
            }
            
        }
        
        return targetIndex
    }
    func addToCart(product: Products, menge: Double, total: Double) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Warenkorb", in: managedContext)
        let productToAdd = NSManagedObject(entity: entity!, insertInto: managedContext)
        productToAdd.setValue(checkForProduct(product), forKey: "produkt")
        productToAdd.setValue(menge, forKey: "menge")
        productToAdd.setValue(total, forKey: "total")
        
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        let temp = [Double(checkForProduct(product)), menge, total]
        
        storedCart.append(productToAdd)
        cart.append(temp)
        
    }
    
    func clearCart() {
        
        cart.removeAll()
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Warenkorb")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do
        {
            try managedContext.execute(request)
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func calculateCartTotal() -> Double{
        var total = 0.0
        if self.cart.count > 0 {
            for index in 0...self.cart.count - 1 {
                total += cart[index][4]
            }
        }
        return total
    }
}

