//
//  MapView.swift
//  Heroes
//
//  Created by mac on 2023. 02. 22..
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var latitude: Double;
    @State var longitude: Double;
    var span: MKCoordinateSpan = MKCoordinateSpan(
        latitudeDelta: 0.009, longitudeDelta: 0.009)
    
    @State var region: MKCoordinateRegion;
    
    init(latitude:State<Double>, logitude:State<Double>){
        _latitude = latitude
        _longitude = logitude
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude.wrappedValue, longitude: logitude.wrappedValue),
            span: self.span))
    }
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
    
}
    
