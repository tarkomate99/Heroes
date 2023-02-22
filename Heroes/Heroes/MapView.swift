//
//  MapView.swift
//  Heroes
//
//  Created by mac on 2023. 02. 22..
//

import SwiftUI
import MapKit



struct MapView: View {
    
    @State var hero: Hero;
    @State var latitude: Double;
    @State var longitude: Double;
    var span: MKCoordinateSpan = MKCoordinateSpan(
        latitudeDelta: 0.0009, longitudeDelta: 0.0009)
    
    @State var region: MKCoordinateRegion;
    
    init(latitude:State<Double>, logitude:State<Double>, hero:State<Hero>){
        _latitude = latitude
        _longitude = logitude
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude.wrappedValue, longitude: logitude.wrappedValue),
            span: self.span))
        _hero = hero
    }
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            Text(self.hero.name)
                .font(.system(size: 17)).bold()
            Map(coordinateRegion: $region, annotationItems: viewModel.locations.filter {
                $0.location.longitude == self.longitude && $0.location.latitude == self.latitude
            }) { loc in
                MapAnnotation(coordinate: loc.location){
                    AsyncImage(url: URL(string: loc.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(hex: 0xc82626), lineWidth: 1))
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 26, height: 26)
                    .clipShape(Circle())
                }
            }
            .ignoresSafeArea()
            .onAppear{
                viewModel.fetch()
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}
    
