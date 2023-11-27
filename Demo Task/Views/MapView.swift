//
//  MapView.swift
//  Demo Task
//
//  Created by Devasis KC on 26/11/2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var location: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Convert location to coordinate and add a pin on the map
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let coordinate = location.coordinate
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                uiView.addAnnotation(annotation)
                
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                uiView.setRegion(region, animated: true)
            }
        }
    }
}
