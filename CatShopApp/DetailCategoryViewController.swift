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
    
    static let firstStartSettingKey = "firstStart"
    
    var currentCategory: Kategorie = Kategorie()
    var products: [Produkt] = [Produkt]()
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var cat: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    
    
    override func viewDidLoad() {
        self.insertDemoProducts()
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        img.image = UIImage(named: currentCategory.image!)
        cat.text = currentCategory.name
        
        let isFirstStart = UserDefaults.standard.object(forKey: DetailCategoryViewController.firstStartSettingKey) as? Bool
        if isFirstStart == false {
                insertDemoProducts()
                UserDefaults.standard.set(true, forKey: DetailCategoryViewController.firstStartSettingKey)
        }
        fetchProducts()
    }
    
    func insertDemoProducts(){
        let productDescription = NSEntityDescription.entity(forEntityName: "Produkt", in: self.appDelegate.persistentContainer.viewContext)
        
        if let productDescription = productDescription{
            let product1 = Produkt(entity: productDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            product1.name = "Kratzbaum1"
            product1.preis = 42.00
            product1.beschreibung = "Ein wunderwollver Kratzbaum mit tollen Eigenschaften <3"
            product1.image = "Kratzbaum_1"
//            product1.kategorie = self.currentCategory
            
            
            let product2 = Produkt(entity: productDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            product2.name = "Kratzbaum1"
            product2.preis = 52.00
            product2.beschreibung = "Ein wunderwollver Kratzbaum mit tollen Eigenschaften <3"
            product2.image = "Kratzbaum_2"
//            product1.kategorie = Kategorie()
            
            let product3 = Produkt(entity: productDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            product3.name = "Kratzbaum1"
            product3.preis = 62.00
            product3.beschreibung = "Ein wunderwollver Kratzbaum mit tollen Eigenschaften <3"
            product3.image = "Kratzbaum_3"
//            product1.kategorie = Kategorie()
            
            let product4 = Produkt(entity: productDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            product4.name = "Kratzbaum1"
            product4.preis = 72.00
            product4.beschreibung = "Ein wunderwollver Kratzbaum mit tollen Eigenschaften <3"
            product4.image = "Kratzbaum_4"
//            product1.kategorie = Kategorie()
            
            self.appDelegate.saveContext()
        }
    }
    
    func fetchProducts(){
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Produkt")
        do {
            if let results = try self.appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
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
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
//        cell.nameLabel.text = products[indexPath.item].name
//        cell.preisLabel.text = products[indexPath.item].preis.description + "€"
//        cell.img.image = UIImage(named: products[indexPath.item].image!)
//        return cell
    }
}

extension DetailCategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProductView") as? ProductViewController {

            vc.dbeschreibung = products[indexPath.row].beschreibung!
            vc.dname = products[indexPath.row].name!
            vc.dpreis = products[indexPath.row].preis
            vc.dimage = UIImage(named: products[indexPath.row].image!)!
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
