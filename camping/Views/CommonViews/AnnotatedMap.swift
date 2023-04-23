//
//  AnnotatedMap.swift
//  camping
//
//  Created by Eric Askari on 22.4.2023.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

struct AnnotatedMap: View {
    @Binding var region: MKCoordinateRegion
    var campingSites: [CampingSite]
    var didChooseCampsite: (CampingSite) -> ()

    var body: some View {
        let binding = Binding(
            get: { self.region },
            set: { newValue in
                DispatchQueue.main.async {
                    self.region = newValue
                }
            }
        )

        return Map(
            coordinateRegion: binding,
            showsUserLocation: true,
            annotationItems: campingSites,
            annotationContent: {
                // apMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .red)
                n in MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: n.latitude, longitude: n.longitude)) {
                    Image(systemName: "tent.circle.fill")
                        .frame(width: 44, height: 44)
                        .onTapGesture(count: 1, perform: {
                            didChooseCampsite(n)
                        })
                }
            }
        )
    }
}
