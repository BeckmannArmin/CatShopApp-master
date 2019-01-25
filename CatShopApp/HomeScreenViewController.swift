//
//  HomeScreenViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 13.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController{
    //Kategorien
    var categoriesName=["SALE","KRATZBÄUME","NÄPFE","CATNIP","FOODINGS"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        addNavBarImage()
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
        return categoriesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryCell
        cell?.lbl.text = categoriesName[indexPath.row]
        cell?.img.image = UIImage(named: categoriesName[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailCategoryViewController") as? DetailCategoryViewController {
            vc.image = UIImage(named: categoriesName[indexPath.row].description)!
            vc.category = categoriesName[indexPath.row]
            
        navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    
    
}
