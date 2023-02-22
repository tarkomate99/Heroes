//
//  MapView.swift
//  Heroes
//
//  Created by mac on 2023. 02. 22..
//

import SwiftUI
import MapKit

struct Location: Identifiable{
    let id = UUID()
    let latitude: Double
    let longitude: Double
}

struct JSONdata{
    let locations: [Location]
}

struct MapView: View {
    
    @State var latitude: Double;
    @State var longitude: Double;
    @State private var locations: [Location] = []
    var span: MKCoordinateSpan = MKCoordinateSpan(
        latitudeDelta: 0.001, longitudeDelta: 0.001)
    
    @State var region: MKCoordinateRegion;
    
    init(latitude:State<Double>, logitude:State<Double>){
        _latitude = latitude
        _longitude = logitude
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude.wrappedValue, longitude: logitude.wrappedValue),
            span: self.span))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { loc in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)){
                Image(systemName: "star.fill")
                    .foregroundColor(.red)
                    .shadow(radius: 1)
            }
        }
    }
    
}
    
