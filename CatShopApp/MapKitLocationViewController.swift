//
//  MapKitLocationViewController.swift
//  CatShopApp
//
//  Created by Armin Beckmann on 13.01.19.
//  Copyright © 2019 Armin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapKitLocationViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    var centerUserPosition: Bool = true
    var lastUserLocation: MKUserLocation?
    var locations: [MKPointAnnotation] = []
    var isUserInteraction: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.createAnnotation()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    func createAnnotation() {
        let annoationCologne: MKPointAnnotation = MKPointAnnotation()
        annoationCologne.coordinate = CLLocationCoordinate2DMake(50.93, 6.95)
        annoationCologne.title = "CatShop Cologne"
        annoationCologne.subtitle = "Neumarktallee 42"
        self.locations.append(annoationCologne)
        
        let annoationDüsseldorf: MKPointAnnotation = MKPointAnnotation()
        annoationDüsseldorf.coordinate = CLLocationCoordinate2DMake(51.22, 6.77)
        annoationDüsseldorf.title = "CatShop Düsseldorf"
        annoationDüsseldorf.subtitle = "Neumarktallee 42"
        self.locations.append(annoationDüsseldorf)
        
        self.mapView.addAnnotations(self.locations)
    }
    
    @IBAction func myLocationBarButton(_ sender: UIBarButtonItem) {
        if self.lastUserLocation != nil {
            let region: MKCoordinateRegion = MKCoordinateRegion(center: lastUserLocation!.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            self.mapView.setRegion(region, animated: true)
            
            let selectedIndexPath: IndexPath? = self.tableView.indexPathForSelectedRow
            if selectedIndexPath != nil {
                self.tableView.deselectRow(at: selectedIndexPath!, animated: true)
            }
        }
        
    }
    
    
}

extension MapKitLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if self.centerUserPosition {
            let region: MKCoordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            self.mapView.setRegion(region, animated: true)
            self.centerUserPosition = false
        }
        
        self.lastUserLocation = userLocation
    }
    
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        // Error
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation{
            return nil
        }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named: "storeIcon")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if self.isUserInteraction {
            let selectedIndexPath: IndexPath? = self.tableView.indexPathForSelectedRow
            if selectedIndexPath != nil {
                self.tableView.deselectRow(at: selectedIndexPath!, animated: true)
            }
        }
        else {
            self.isUserInteraction = true
        }
    }
    
}


extension MapKitLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "defaultCell")
        }
        
        let annotation: MKPointAnnotation = self.locations[indexPath.row]
        cell!.textLabel?.text = annotation.title
        cell!.detailTextLabel?.text = annotation.subtitle
        
        return cell!
    }
}


extension MapKitLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let annotation: MKPointAnnotation = self.locations[indexPath.row]
        for an in self.mapView.annotations {
            let pointAnnotation: MKPointAnnotation? = an as? MKPointAnnotation
            if pointAnnotation != nil {
                if pointAnnotation == annotation {
                    self.isUserInteraction = false
                    let region: MKCoordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
                    self.mapView.setRegion(region, animated: true)
                    
                }
            }
        }
    }
}


