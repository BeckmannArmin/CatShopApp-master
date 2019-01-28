//
//  HomeScreenViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 13.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomeScreenViewController: UIViewController{
    //Kategorien
//    var categoriesName=["SALE","KRATZBÄUME","NÄPFE","CATNIP","FOODINGS"]
    var categories: [Kategorie] = [Kategorie]() // new
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate // new
    static let firstStartSettingKey = "firstStart" //new
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        addNavBarImage()
        
        //NEW
        let isFirstStart = UserDefaults.standard.object(forKey: HomeScreenViewController.firstStartSettingKey) as? Bool
        
        if isFirstStart == nil{
            insertDemoCategories()
            UserDefaults.standard.set(true, forKey: HomeScreenViewController.firstStartSettingKey)
        }
        
        fetchCategories()
        
    }
    
    
    //new
    func insertDemoCategories(){
        let categorieDescription = NSEntityDescription.entity(forEntityName: "Kategorie", in: self.appDelegate.persistentContainer.viewContext)
        
        if let categorieDescription = categorieDescription{
            let categorie1 = Kategorie(entity: categorieDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            categorie1.name = "KRATZBÄUME"
            categorie1.image = "KRATZBÄUME"
            
            let categorie2 = Kategorie(entity: categorieDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            categorie2.name = "NÄPFE"
            categorie2.image = "NÄPFE"
           
            let categorie3 = Kategorie(entity: categorieDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            categorie3.name = "CATNIP"
            categorie3.image = "CATNIP"
           
            let categorie4 = Kategorie(entity: categorieDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            categorie4.name = "FOODINGS"
            categorie4.image = "FOODINGS"
            
            self.appDelegate.saveContext()
            
        }
    }
    
    func fetchCategories(){
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Kategorie")
        do {
            if let results = try self.appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
                let fetchedCategorie: [Kategorie]? = results as? [Kategorie]
                if fetchedCategorie != nil {
                    self.categories = fetchedCategorie!
                }
            }
        }
        catch {
            fatalError("There was an error fetching the cars")
        }
        
    }
    
    func addNavBarImage(){
        let navController = navigationController!
        let image = UIImage(named: "Logo")
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - image!.size.width / 2
        let bannerY = bannerHeight / 2 - image!.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categorie = self.categories[indexPath.row]
        let cell: CategoryCell? = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryCell
        
        if let cell = cell{
            cell.setup(withCategorie: categorie)
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailCategoryViewController") as? DetailCategoryViewController {
                vc.currentCategory = categories[indexPath.row] 
        navigationController?.pushViewController(vc, animated: true)
        }



    }
    
    
}
