//
//  ShoppingCartViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 28.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {
   
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
  

}

extension ShoppingCartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension ShoppingCartViewController: UITableViewDelegate{
    
}
