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
    
    var categories: [Kategorie] = [Kategorie]()
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let firstStartSettingKey = "firstStart"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        addNavBarImage()
        
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
            let categorie0 = Kategorie(entity: categorieDescription, insertInto: self.appDelegate.persistentContainer.viewContext)
            categorie0.name = "SALE"
            categorie0.image = "SALE"
            
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
            categorie4.name = "FUTTER"
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
    
    func addNavBarImage() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "BarLogo")
        imageView.image = image
        
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
