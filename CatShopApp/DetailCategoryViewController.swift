//
//  DetailCategoryViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 14.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit
import Foundation
import CoreData



class DetailCategoryViewController: UIViewController {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let firstStartSettingKey = "secondStart"
    
    var currentCategory: Kategorie = Kategorie()
    var products: [Produkt] = [Produkt]()
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var cat: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        collectionView.delegate = self
        collectionView.dataSource = self
        img.image = UIImage(named: currentCategory.image!)
        cat.text = currentCategory.name
 
        
        let isFirstStart = UserDefaults.standard.object(forKey: DetailCategoryViewController.firstStartSettingKey) as? Bool
        if isFirstStart == nil {
                insertDemoProducts()
                UserDefaults.standard.set(true, forKey: DetailCategoryViewController.firstStartSettingKey)
        }
        fetchProducts()
    }
    
    func addNavBarImage() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "BarLogo")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
    
    func insertDemoProducts(){
        let productDescription = NSEntityDescription.entity(forEntityName: "Produkt", in: self.appDelegate.persistentContainer.viewContext)
        
        var categories:[Kategorie] = []
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Kategorie")
            do {
                if let results = try
                    self.appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
                    let fetchedCategories:[Kategorie]? = results as? [Kategorie]
                    if fetchedCategories != nil {
                        categories = fetchedCategories!
                    }
                }
            }
            catch {
                fatalError("There was an error fetching the items")
        }
        print(categories)
        
        if let productDescription = productDescription{
            let product1 = Produkt(entity: productDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            product1.name = "Kratzbaum Helga"
            product1.preis = 42.00
            product1.beschreibung = "Ein wunderwollver Kratzbaum mit tollen Eigenschaften <3"
            product1.image = "Kratzbaum_1"
            product1.uid = "p1"
            product1.kategorie = categories[3]
            
            
            let product2 = Produkt(entity: productDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            product2.name = "Kratzbaum Bert"
            product2.preis = 52.00
            product2.beschreibung = "Ein wunderwollver Kratzbaum mit tollen Eigenschaften <3"
            product2.image = "Kratzbaum_2"
            product2.uid = "p2"
            product2.kategorie = categories[3]
            
            let product3 = Produkt(entity: productDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            product3.name = "Kratzbaum Emil"
            product3.preis = 62.00
            product3.beschreibung = "Ein wunderwollver Kratzbaum mit tollen Eigenschaften <3"
            product3.image = "Kratzbaum_3"
            product3.uid = "p3"
            product3.kategorie = categories[3]
            
            let product4 = Produkt(entity: productDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            product4.name = "Kratzbaum Gisela"
            product4.preis = 72.00
            product4.beschreibung = "Ein wunderwollver Kratzbaum mit tollen Eigenschaften <3"
            product4.image = "Kratzbaum_4"
            product4.uid = "p4"
            product4.kategorie = categories[3]
            
            self.appDelegate.saveContext()
        }
    }
    
    func fetchProducts(){
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Produkt")
        do {
            if let results = try self.appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject]  {
                let fetchedProducts: [Produkt]? = results as? [Produkt]
                if fetchedProducts != nil {
                    self.products = fetchedProducts!
                }
            }
        }
        catch {
            fatalError("There was an error fetching the items")
        }
    }
}
extension DetailCategoryViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.products[indexPath.row]
        let cell: CollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell

        if let cell = cell{
            cell.setup(withProducts: product)
        }

        return cell!
    }
}

extension DetailCategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProductView") as? ProductViewController {
            vc.currentProduct = products[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
