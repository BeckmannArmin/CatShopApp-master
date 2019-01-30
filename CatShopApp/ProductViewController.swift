//
//  ProductViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 17.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    let model = SingletonManager.model
    
    var productItem: Products!
   
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var preis: UILabel!
    @IBOutlet weak var beschreibung: UILabel!
    
//
//    var dimage = UIImage()
//    var dname: String = ""
//    var dpreis: Double = 0
//    var dbeschreibung: String = ""
    var currentProduct: Produkt!
    var menge: Int = 1
    var total: Double = 0.0
    
    var alertController: UIAlertController?
    var alertTimer: Timer?
    var remainingTime = 0.0
    var baseMessage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        name.text = currentProduct.name
        image.image = UIImage(named: currentProduct.image!)
        preis.text = currentProduct.preis.description + "€"
        beschreibung.text = currentProduct.beschreibung
        
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        if let product = self.productItem{
            model.addToCart(product: product, menge: Double(menge), total: total)
        }
        showAlert("Erfolgreich", message: "Produkte wurden hinzugefügt", time: 1.0)
    }
    
    func showAlert(_ title: String, message: String, time: Double){
        guard (self.alertController == nil) else {
            return
        }
        self.baseMessage = message
        self.remainingTime = time
        self.alertController = UIAlertController(title: title, message: self.baseMessage, preferredStyle: .alert)
        self.alertTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown(){
        self.remainingTime -= 1
        if (self.remainingTime < 0){
            self.alertTimer?.invalidate()
            self.alertTimer = nil
            self.alertController!.dismiss(animated: true, completion:{
                self.alertController = nil
            })
        }else{
                self.alertController!.message = self.alertMessage()
            }
        }
    
    func alertMessage() -> String{
        var message = ""
        if let baseMessage = self.baseMessage{
            message = baseMessage + " "
        }
        return(message)
    }
    
    func addNavBarImage() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "BarLogo")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
}
