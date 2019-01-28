//
//  AppDelegate.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 13.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var locationManager: CLLocationManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.locationManager = CLLocationManager()
        self.locationManager?.requestWhenInUseAuthorization()

        return true
    }


    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
  
         */
        let container = NSPersistentContainer(name: "CatShopApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

//Produkte
//    func createData()
//    {
//        guard UserDefaults.standard.object(forKey: "firstStart") == nil,
//            let productEntity = NSEntityDescription.entity(forEntityName: "Produkt", in: self.coreDataStack.managedObjectContext),
//            let categoryEntity = NSEntityDescription.entity(forEntityName: "Kategorie", in: self.coreDataStack.managedObjectContext)
//            else {
//                return
//        }
//        UserDefaults.standard.set(false, forKey: "firstStart")
//
//        let categorie1 = createCategory(categoryEntity, name: "Kratzbäume", image: "KRATZBÄUME")
//
//        _ = [("Kratzbaum1","Ein großer Kratzbaum mit vielen Möglichkeiten zum Spielen, Klettern und Schlafen <3","Kratzbaum_1",42),("Kratzbaum2","Ein weiterer großer Kratzbaum mit vielen Möglichkeiten zum Spielen, Klettern und Schlafen <3)","Kratzbaum_2",52),("Kratzbaum3","Ein großer Kratzbaum mit vielen Möglichkeiten zum Spielen, Klettern und Schlafen <3","Kratzbaum_3",62),("Kratzbaum4","Ein großer Kratzbaum mit vielen Möglichkeiten zum Spielen, Klettern und Schlafen <3","Kratzbaum_4",72)].map{
//            produktDaten in
//            return createProducts(productEntity, name: produktDaten.0, beschreibung: produktDaten.1, image: produktDaten.2, preis: produktDaten.3)}
//
//
//
//        let categorie2 = createCategory(categoryEntity, name: "Näpfe", image: "NÄPFE")
//        _ = [("Napf1","Ein sehr schöner Napf mit einem großen Fassungsvermögen zum daraus trinken und schlürfen","napf1",10),("Napf2","Ein weiterer sehr schöner Napf mit einem großen Fassungsvermögen zum daraus trinken und schlürfen","napf2",20),("Napf3","Ein sehr schöner Napf mit einem großen Fassungsvermögen zum daraus trinken und schlürfen","napf3",30),("Napf4","Und noch ein sehr schöner Napf mit einem großen Fassungsvermögen zum daraus trinken und schlürfen","napf4",40)].map{
//            produktDaten in
//            return createProducts(productEntity, name: produktDaten.0, beschreibung: produktDaten.1, image: produktDaten.2, preis: produktDaten.3)}
//
//        let categorie3 = createCategory(categoryEntity, name: "Catnip", image: "CATNIP")
//        _ = [("Catnip1","Futter bei der jede Katze in Extase verfällt!","catnip1",420),("Catnip2","Noch mehr Futter bei der jede Katze in Extase verfällt!","catnip2",420), ("Catnip3","Futter bei der jede Katze in Extase verfällt!","catnip3",420),("Catnip4","Futter bei der jede Katze in Extase verfällt!","catnip4",420),("Catnip4","Futter bei der jede Katze in Extase verfällt!","catnip4",420)].map{
//            produktDaten in
//            return createProducts(productEntity, name: produktDaten.0, beschreibung: produktDaten.1, image: produktDaten.2, preis: produktDaten.3)}
//
//        let categorie4 = createCategory(categoryEntity, name: "Foodings", image: "FOODINGS")
//        _ = [("Futter1","Sehr leckeres Katzenfutter! Mhmhmhmhmhmhmh leeeckerrrrr","futter1",100),("Futter2","Sehr leckeres Katzenfutter! Mhmhmhmhmhmhmh leeeckerrrrr","futter2",110),("Futter3","Sehr leckeres Katzenfutter! Mhmhmhmhmhmhmh leeeckerrrrr","futter3",100),("Futter4","Sehr leckeres Katzenfutter! Mhmhmhmhmhmhmh leeeckerrrrr","futter4",100)].map{
//            produktDaten in
//    return createProducts(productEntity, name: produktDaten.0, beschreibung: produktDaten.1, image: produktDaten.2, preis: produktDaten.3)}
//
//        self.coreDataStack.saveContext()
//
//    }
//
//
//    private func createProducts(_ entität: NSEntityDescription, beschreibung: String, preis: Double, name: String, image: String) -> Produkt{
//        let produkt: Produkt = Produkt(entity: entität, insertInto: self.coreDataStack.managedObjectContext)
//        produkt.beschreibung = beschreibung
//        produkt.preis = preis
//        produkt.name = name
//        produkt.image = image
//        return produkt
//    }
//    private func createCategory(_ entität: NSEntityDescription, name: String, image: String) -> Kategorie {
//        let mainCategory: Kategorie = Kategorie(entity: entität, insertInto: self.coreDataStack.managedObjectContext)
//        mainCategory.name = name
//        mainCategory.image = image
//        return mainCategory
//    }
