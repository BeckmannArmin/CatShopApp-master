//
//  CollectionCell.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 17.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    // Test1
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var preisLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
 
    
    func setup(withProducts product: Produkt){
        self.nameLabel.text = product.name
        self.preisLabel.text = "\(product.preis)" + "€"
        self.img.image = UIImage(named: product.image!)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
