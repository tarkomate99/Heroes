//
//  MapView.swift
//  Heroes
//
//  Created by mac on 2023. 02. 21..
//

import SwiftUI
import MapKit
struct MapView: View {
    
    let hero: Hero
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    
    
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: , longitude: ),
                                    latitudinalMeters: 5,
                                            longitudinalMeters: 5)
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
}
