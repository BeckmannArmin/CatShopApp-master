//
//  CategoryCell.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 14.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell: UITableViewCell{
    
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    func setup(withCategorie categorie: Kategorie){
        self.lbl.text = categorie.name
        self.img.image = UIImage(named: categorie.image!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
