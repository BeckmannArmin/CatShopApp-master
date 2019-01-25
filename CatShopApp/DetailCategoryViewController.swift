//
//  DetailCategoryViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 14.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit
import Foundation

class Product2 {
    var name: String?
    var beschreibung: String?
    var pic: UIImage?
    var preis: Double?
    
    init(name: String, beschreibung:String, pic: UIImage, preis:Double) {
        self.name = name
        self.beschreibung = beschreibung
        self.pic = pic
        self.preis = preis
    }
    
    
}

class DetailCategoryViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var cat: UILabel!
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var image = UIImage()
    var category: String = ""
    
    var baume = [Product2]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        img.image = image
        cat.text = category
        let i1 = Product2(name:"Kratzbaum 'Miau'", beschreibung:"Ein großer Kratzbaum mit vielen Möglichkeiten zum Spielen, Klettern und Schlafen <3", pic:UIImage(named: "Kratzbaum_1")!, preis:129.99)
        baume.append(i1)
        let i2 = Product2(name:"Kratzbaum 'Miauu'", beschreibung:"Ein großer Kratzbaum mit vielen Möglichkeiten zum Spielen, Klettern und Schlafen <3", pic:UIImage(named: "Kratzbaum_2")!, preis:199.99 )
        baume.append(i2)
        let i3 = Product2(name:"Kratzbaum 'Miauuu'", beschreibung:"Ein großer Kratzbaum mit vielen Möglichkeiten zum Spielen, Klettern und Schlafen <3", pic:UIImage(named: "Kratzbaum_3")!, preis:19.99)
        baume.append(i3)
        let i4 = Product2(name:"Kratzbaum 'Miauuuu'", beschreibung:"Ein großer Kratzbaum mit vielen Möglichkeiten zum Spielen, Klettern und Schlafen <3", pic:UIImage(named: "Kratzbaum_4")!, preis:14.99)
        baume.append(i4)
        
    }
}
extension DetailCategoryViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baume.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        cell.nameLabel.text = baume[indexPath.item].name
        cell.preisLabel.text = (baume[indexPath.item].preis?.description)! + "€"
        cell.img.image = baume[indexPath.item].pic
        return cell
    }
}

extension DetailCategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProductView") as? ProductViewController {
            vc.dimage = baume[indexPath.row].pic!
            vc.dbeschreibung = baume[indexPath.row].beschreibung!
            vc.dname = baume[indexPath.row].name!
            vc.dpreis = baume[indexPath.row].preis!
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
