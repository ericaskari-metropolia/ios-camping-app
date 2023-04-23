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
    //  To Access Location
    @StateObject var viewModel: LocationViewModel = .init()

    @Binding var isPresented: Bool

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var campingSites: FetchedResults<CampingSite>

    var didChooseLocation: (CLLocationCoordinate2D) -> ()

    var body: some View {
        ZStack(alignment: .top) {
            AnnotatedMap(
                region: $viewModel.region,
                campingSites: self.campingSites.map { $0 },
                didChooseCampsite: { _ in
                }
            )
            .ignoresSafeArea()
            .tint(.pink)

            ZStack(alignment: .top) {
                VStack {
                    Text("Select location by placing blue circle on the location")
                        .multilineTextAlignment(.center)
                }.frame(maxWidth: .infinity).padding()
                    .background(.white)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }.frame(maxWidth: .infinity)
                .padding()

            ZStack {
                Circle()
                    .fill(.blue)
                    .opacity(0.5)
                    .frame(width: 32, height: 32)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Button(
                            action: {
                                didChooseLocation(viewModel.region.center)
                                isPresented.toggle()
                            }, label: {
                                Text("Select")
                                    .frame(maxWidth: .infinity)
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                            }
                        )
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(
                            action: {
                                viewModel.requestPermission()
                            }, label: {
                                Text("My location")
                                    .frame(maxWidth: .infinity)
                                Image(systemName: "location.circle.fill")
                                    .font(.system(size: 20))
                            }
                        )
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Button(
                            action: {
                                self.isPresented.toggle()
                            }, label: {
                                Text("Return")
                                    .frame(maxWidth: .infinity)
                                Image(systemName: "return")
                                    .font(.system(size: 20))
                            }
                        )
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                    .frame(maxWidth: 200)
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
