//
//  ViewController.swift
//  selection-poc
//
//  Created by Samuel Haycraft on 12/21/22.
//

import UIKit

import ArcGIS

class ViewController: UIViewController {
    @IBOutlet weak var mapView: AGSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMap()
    }
    
    private func setupMap() {
        let map = AGSMap(
            basemapStyle: .arcGISTopographic
        )
        
        mapView.map = map
        
        mapView.setViewpoint(
            AGSViewpoint(
                latitude: 34.02700,
                longitude: -118.80500,
                scale: 72_000
            )
        )
        
    }
    
}

