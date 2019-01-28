//
//  SearchFunctionViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 27.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import Foundation
import UIKit

class SearchFunctionViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    
    var product = [Produkt]()
    var currentProducts = [Produkt]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.searchBar.delegate = self
        fetchProducts()
    }
    private func fetchProducts(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? searchCell else{
            fatalError("The dequeued cell is not an instance of searchCell.")
        }
        
        cell.beschreibung.text = currentProducts[indexPath.row].beschreibung
        //      Backgroundfarbe der selektierten Zelle
        let backgroundView = UIView()
        backgroundView.backgroundColor = .red
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            currentProducts = product
            tableView.reloadData()
            return
        }
        // Function return type -> Bool
        currentProducts = product.filter({item -> Bool in
            guard let text = searchBar.text else { return false }
            return item.beschreibung!.contains(text)
        })
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = true
        currentProducts = product
        tableView.reloadData()
    }
}
