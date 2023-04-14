//
//  AddPlanChooseLocationModalView.swift
//  camping
//
//  Created by Eric Askari on 13.4.2023.
//

import CoreLocation
import CoreLocationUI
import MapKit
import SwiftUI

struct AddPlanChooseStartLocationModalView: View {
    @StateObject private var viewModel = LocationViewModel()

    @Binding var isPresented: Bool

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var campingSites: FetchedResults<CampingSite>

    var didChooseLocation: (CampingSite) -> ()

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(
                coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: campingSites,
                annotationContent: {
                    n in MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: n.latitude, longitude: n.longitude)) {
                        Image("location")
                            .frame(width: 44, height: 44)
                            .onTapGesture(count: 1, perform: {
                                didChooseLocation(n)
                                self.isPresented.toggle()
                            })
                    }
                }
            )
            .ignoresSafeArea()
            .tint(.pink)

            VStack {
                LocationButton(.currentLocation) {
                    viewModel.requestPermission()
                }
                .foregroundColor(.white)
                .cornerRadius(8)
                .symbolVariant(.fill)
                .labelStyle(.titleAndIcon)
                .symbolVariant(.fill)
                .tint(.pink)
                .padding()

                Button(
                    action: {
                        print(campingSites.count)
                        self.isPresented.toggle()
                    }, label: {
                        Text("Close")
                    }
                ).padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct AddPlanChooseLocationModalView_Previews: PreviewProvider {
    @State var isPresented: Bool = true
    static var previews: some View {
        AddPlanChooseStartLocationModalView(
            isPresented: .constant(true)
        ) {
            coordinates in
            print(coordinates)
        }
    }
}
