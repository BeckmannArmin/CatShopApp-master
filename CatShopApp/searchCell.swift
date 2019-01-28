//
//  searchCell.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 27.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import Foundation
import UIKit

class searchCell: UICollectionViewCell{
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgLabel: UIImageView!
    @IBOutlet weak var preisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(withProducts product: Produkt){
        self.nameLabel.text = product.name
        self.preisLabel.text = "\(product.preis)" + "€"
        self.imgLabel.image = UIImage(named: product.image!)
    }
}
