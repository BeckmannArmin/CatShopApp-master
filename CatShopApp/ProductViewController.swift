//
//  ProductViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 17.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var preis: UILabel!
    @IBOutlet weak var beschreibung: UILabel!
    
    
    var dimage = UIImage()
    var dname: String = ""
    var dpreis: Double = 0
    var dbeschreibung: String = ""
    var currentProduct: Produkt!
    
    
    @IBAction func button(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = dname
        image.image = dimage
        preis.text = dpreis.description + "€"
        beschreibung.text = dbeschreibung
        
        
        
    }
    
}
