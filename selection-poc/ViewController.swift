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
            mapView.graphicsOverlays.addObjects(from: [mapLineGraphicsOverlay()])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func mapLineGraphicsOverlay() -> AGSGraphicsOverlay {
        // Create a simple fill symbol.
        let lineSymbol = AGSSimpleLineSymbol(style: .solid, color: .red, width: 3.2)
        // Create a graphics overlay for the square polygons.
        let lineGraphicsOverlay = AGSGraphicsOverlay()
        // Create and assign a simple renderer to the graphics overlay.
        lineGraphicsOverlay.renderer = AGSSimpleRenderer(symbol: lineSymbol)
        
        // Create a polyline graphic with `AGSPolyline` geometry.
        let polylineBuilder = AGSPolylineBuilder(spatialReference: .wgs84())
        polylineBuilder.addPointWith(x: -118.80500, y: 34.02700)
        polylineBuilder.addPointWith(x: -118.80, y: 34.02)
        
        
        let polylineGraphic = AGSGraphic(geometry: polylineBuilder.toGeometry(), symbol: nil)
        // Add the graphic to the overlay.
        lineGraphicsOverlay.graphics.add(polylineGraphic)
        return lineGraphicsOverlay
    }
    
    
    private func setupMap() -> AGSMap {
        let map = AGSMap(
            basemapStyle: .arcGISTopographic
        )
        //        let map = AGSMap(spatialReference: AGSSpatialReference(wkid: 4326)!)
        map.basemap = AGSBasemap(style: .arcGISHillshadeDark)
        
        let featureLayer: AGSFeatureLayer = {
            let featureServiceURL = URL(string: SERVICE_URL)!
            let trailheadsTable = AGSServiceFeatureTable(url: featureServiceURL)
            return AGSFeatureLayer(featureTable: trailheadsTable)
        }()
        map.operationalLayers.add(featureLayer)
        
        return map;
        
    }
    
}

