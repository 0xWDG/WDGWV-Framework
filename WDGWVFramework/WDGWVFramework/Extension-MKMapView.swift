//
//  Extension-MKMapView.swift
//  WDGFramework
//
//  Created by Wesley de Groot on 13/08/2018.
//  Copyright © 2018 WDGWV. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    func newAnnotation(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let x = MKPointAnnotation.init()
        x.title = title
        x.subtitle = subtitle
        x.coordinate = coordinate
        self.addAnnotation(x)
    }
    
    func addAnnotation(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let x = MKPointAnnotation.init()
        x.title = title
        x.subtitle = subtitle
        x.coordinate = coordinate
        self.addAnnotation(x)
    }
}
