//
//  ViewController.swift
//  selection-poc
//
//  Created by Samuel Haycraft on 12/21/22.
//

import UIKit

import ArcGIS

class ViewController: UIViewController {
    let SERVICE_URL = "https://services3.arcgis.com/GVgbJbqm8hXASVYi/arcgis/rest/services/Trailheads/FeatureServer/0"
    
    @IBOutlet weak var mapView: AGSMapView! {
        didSet {
            mapView.map = self.setupMap()
            mapView.setViewpoint(AGSViewpoint(latitude:34.02700, longitude: -118.80500, scale: 72_000))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupMap() -> AGSMap {
        let map = AGSMap(
            basemapStyle: .arcGISTopographic
        )
        
        let featureLayer: AGSFeatureLayer = {
            let featureServiceURL = URL(string: SERVICE_URL)!
            let trailheadsTable = AGSServiceFeatureTable(url: featureServiceURL)
            return AGSFeatureLayer(featureTable: trailheadsTable)
        }()
        map.operationalLayers.add(featureLayer)
        
        return map;
        
    }
    
}

