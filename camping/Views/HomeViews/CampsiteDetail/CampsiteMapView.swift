//
//  CampsiteMapView.swift
//  camping
//
//  Created by The Minions on 18.4.2023.
//

import SwiftUI
import MapKit

// Mark: Campsite view on map
struct CampsiteMapView: View {
    @Environment(\.dismiss) var dismiss
    
    struct Annotation: Identifiable {
        let id = UUID().uuidString
        var name: String
        var address: String
        var coordinate: CLLocationCoordinate2D
    }
    
    var campsite: CampingSite
    
    @State private var region =  MKCoordinateRegion()
    @State private var coordinate = CLLocationCoordinate2D()
    @State private var annotations: [Annotation] = []
    let regionSize = 2000.0 // meters
    
    var body: some View {
        
        VStack {
            Map(coordinateRegion: $region, annotationItems: annotations){
                annotation in
                MapAnnotation(
                    coordinate: annotation.coordinate,
                    content: {
                        Image(systemName: "pin.circle.fill").foregroundColor(.red)
                        Text(annotation.name)
                            .font(.subheadline)
                        Text(annotation.address)
                            .font(.subheadline)
                    }
                )            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .ignoresSafeArea(.all)
        }
        .onAppear{
            coordinate = CLLocationCoordinate2D(latitude: campsite.latitude, longitude: campsite.longitude)
            region = MKCoordinateRegion(center:  coordinate, latitudinalMeters: regionSize, longitudinalMeters: regionSize)
            annotations = [Annotation(name: (campsite.name ?? ""),address: (campsite.address ?? ""), coordinate: coordinate)]
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button{
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.title)
                .padding()
        }
            .symbolVariant(.circle.fill)
            .foregroundStyle(Color("PrimaryColor"), .white)
        )
    }
}
