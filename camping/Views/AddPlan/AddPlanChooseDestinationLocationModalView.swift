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

struct AddPlanChooseDestinationLocationModalView: View {
    //  To Access Location
    @EnvironmentObject var viewModel: LocationViewModel

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
                        Image(systemName: "tent.fill")
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
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(
                            action: {
                                viewModel.requestPermission()
                            }, label: {
                                Image(systemName: "location.circle.fill")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.system(size: 20))
                            }
                        )
                        Button(
                            action: {
                                self.isPresented.toggle()
                            }, label: {
                                Image(systemName: "return")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.system(size: 20))
                            }
                        )

                    }.padding()
                }
            }
        }
    }
}

struct AddPlanChooseDestinationModalView_Previews: PreviewProvider {
    @State var isPresented: Bool = true
    static var previews: some View {
        AddPlanChooseDestinationLocationModalView(
            isPresented: .constant(true)
        ) {
            coordinates in
            print(coordinates)
        }
        .environmentObject(LocationViewModel())
    }
}
