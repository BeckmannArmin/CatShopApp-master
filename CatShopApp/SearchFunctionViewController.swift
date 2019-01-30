//
//  SearchFunctionViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 27.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SearchFunctionViewController: UIViewController,UISearchBarDelegate,UISearchDisplayDelegate{
   
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var currentCategory: Kategorie = Kategorie()
    var product: [Produkt] = [Produkt]()
    var currentProducts: [Produkt] = [Produkt]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {

        fetchAllProducts()
        
        super.viewDidLoad()
        
        addNavBarImage()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.searchBar.delegate = self
        
    }
 
    
    func fetchAllProducts(){
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Produkt")
        let sectionSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        do{
            if let results = try self.appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
                let fetchedProducts: [Produkt]? = results as? [Produkt]
                if fetchedProducts != nil {
                    self.product = fetchedProducts!
                }
            }
        }
        catch{
            fatalError("There was an error fetching the products")
        }
    }

    func addNavBarImage() {

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit

        let image = UIImage(named: "BarLogo")
        imageView.image = image

        navigationItem.titleView = imageView
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            currentProducts = product
            collectionView.reloadData()
            return
        }

        currentProducts = product.filter({item -> Bool in
            guard let text = searchBar.text else { return false }
            return item.name!.contains(text)
        })
        collectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.showsCancelButton = true
        self.currentProducts = []
        self.collectionView.reloadData()
    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText != ""{
//            var predicate: NSPredicate = NSPredicate()
//            predicate = NSPredicate(format: "name contains[c] '\(searchText)'")
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Produkt")
//            fetchRequest.predicate = predicate
//            do{
//                currentProducts = try context.fetch(fetchRequest) as! [Produkt]
//            }
//            catch{
//                print("Could not get search data")
//            }
//            collectionView.reloadData()
//        }
//    }
}

extension SearchFunctionViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.currentProducts[indexPath.row]
        let cell: searchCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? searchCell

        if let cell = cell{
            cell.setup(withProducts: product)
        }

        return cell!
    }
}
extension SearchFunctionViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProductView") as? ProductViewController {
            vc.currentProduct = product[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



