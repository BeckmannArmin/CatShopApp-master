//
//  ShoppingCartViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 28.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit
import CoreData

class ShoppingCartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let model = SingletonManager.model
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavBarImage()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        displayTotal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func displayTotal(){
        self.totalLabel.text = "€" + String(format: "%.2f", model.calculateCartTotal())
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath) as! ShoppingCartCell
        cell.titelLabel.text = model.products[Int(model.cart[indexPath.row][0])].name
        cell.preisLabel.text = "€" + String(format: "%.2f", model.cart[indexPath.row][1])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete){
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            managedContext.delete(model.storedCart[indexPath.row])
            self.model.storedCart.remove(at: indexPath.row)
            self.model.cart.remove(at: indexPath.row)
            
            do{
                try managedContext.save()
                tableView.reloadData()
                displayTotal()
            }
            catch let error as NSError
            {
                print("Could not save the products \(error), \(error.userInfo)" )
            }
            
            if model.cart.count == 0{
            self.tableView.setEditing(false, animated: true)
            }
        }
    }
    
    func addNavBarImage() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "BarLogo")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
    
    // Checkout muss noch hinzugefügt werden
//    @IBAction func checkout(_ sender: UIButton) {
//        if model.cart.count == 0 {
//            let alert = UIAlertController.init(title: "Einkaufstasche ist leer!", message: "Bitte füge mind. ein Produkt hinzu", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Produkte suchen", style: .default, handler: { _ in
//                self.performSegue(withIdentifier: "DetailCategoryViewController", sender: sender)
//            }))
//            alert.addAction(UIAlertAction.init(title: "Abbrechen", style: .cancel))
//            self.present(alert, animated: true, completion: nil)
//        }
//        else {
//            self.performSegue(withIdentifier: "Checkout",sender: sender)
//        }
//    }
}
