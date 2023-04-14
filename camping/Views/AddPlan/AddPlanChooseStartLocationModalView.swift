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

    var didChooseLocation: (CLLocationCoordinate2D) -> ()

    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: campingSites,
                annotationContent: {
                    n in MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: n.latitude, longitude: n.longitude)) {
                        Image("location")
                            .frame(width: 44, height: 44)
                            .onTapGesture(count: 1, perform: {
                             
                            })
                    }
                }
            )
            .ignoresSafeArea()
            .tint(.pink)

            Circle()
                .fill(.blue)
                .opacity(0.5)
                .frame(width: 32, height: 32)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(
                            action: {
                                didChooseLocation(viewModel.region.center)
                                isPresented.toggle()
                            }, label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.system(size: 20))
                            }
                        )
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
