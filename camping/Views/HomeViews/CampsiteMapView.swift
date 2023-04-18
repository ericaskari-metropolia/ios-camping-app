//
//  CampsiteMapView.swift
//  camping
//
//  Created by Chi Nguyen on 18.4.2023.
//

import SwiftUI
import MapKit

// Mark:
struct CampsiteMapView: View {
    
//    @Environment(\.dismiss) var dismiss

    var longtitude: Double
    var latitude: Double
    @State var region: MKCoordinateRegion
    
    var body: some View {
        
        NavigationView {
                    
                Map(coordinateRegion: $region)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .ignoresSafeArea(.all)
        }
        
    }
   
}

struct CampsiteMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampsiteMapView(longtitude: 23.8463498, latitude: 62.0234115, region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 62.0234115, longitude: 23.8463498), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
}
