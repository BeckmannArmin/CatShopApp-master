//
//  CollectionCell.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 17.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var preisLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
