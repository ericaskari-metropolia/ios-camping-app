//
//  AddPlantFirstStepView.swift
//  camping
//
//  Created by Eric Askari on 3.4.2023.
//

import CoreLocation
import CoreLocationUI
import MapKit
import SwiftUI

struct AddPlanView: View {
    @State private var isStartLocationModalOpen = false
    @State private var isDestinationLocationModalOpen = false
    @State private var isStartDatePickerVisible = false
    @State private var isEndDatePickerVisible = false
    @State var startLocationText: String = ""
    @State var destinationLocationText: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @StateObject private var viewModel = AddPlanViewModel()
    @State var username: String = ""
    @State private var selectedDate = Date()
    @State private var showDatePicker = false

    var body: some View {
        ScrollView {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                Image("header")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 400, maxHeight: 350)
                    .clipped()

                VStack {
                    Text("My trips")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)

                    // The location Espoo is hardcoded, need to be changed
                    Label("You are in Espoo", systemImage: "globe.europe.africa")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                .padding()
                .padding(.bottom, 30)
            }.ignoresSafeArea()

            VStack{
                VStack(alignment: .leading) {
                    Text("Start location")
                    Button(
                        action: {
                            self.isStartLocationModalOpen.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "location")
                                Text("Start location")
                                Spacer()
                            }.padding(.vertical)
                        }
                    )
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .contentShape(Rectangle())
                    .cornerRadius(10)
                    .sheet(isPresented: $isStartLocationModalOpen) {
                        ChooseLocationModalView(
                            isPresented: self.$isStartLocationModalOpen
                        ) {
                            coordinates in

                            print(coordinates)
                        }
                    }.padding(.bottom)

                    Text("Destination location")
                    Button(
                        action: {
                            self.isDestinationLocationModalOpen.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "location")
                                Text("Destination location")
                                Spacer()
                            }.padding(.vertical)
                        }
                    )
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .contentShape(Rectangle())
                    .cornerRadius(10)
                    .sheet(isPresented: $isDestinationLocationModalOpen) {
                        ChooseLocationModalView(
                            isPresented: self.$isDestinationLocationModalOpen
                        ) {
                            coordinates in

                            print(coordinates)
                        }
                    }.padding(.bottom)

                    Text("Start Date")
                    Button(
                        action: {
                            self.isStartDatePickerVisible.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "location")
                                Text("Destination location")
                                Spacer()
                            }.padding(.vertical)
                        }
                    )
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .contentShape(Rectangle())
                    .cornerRadius(10)
                    .padding(.bottom)

                    if isStartDatePickerVisible {
                        DatePicker(
                            "",
                            selection: $startDate,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                    }

                    Text("End Date")
                    Button(
                        action: {
                            self.isEndDatePickerVisible.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "location")
                                Text("Destination location")
                                Spacer()
                            }.padding(.vertical)
                        }
                    )
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .contentShape(Rectangle())
                    .cornerRadius(10)
                    .padding(.bottom)
                    if isEndDatePickerVisible {
                        DatePicker(
                            "",
                            selection: $endDate,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                    }
                    // Extra arguments in call =  Maximum number of views in this VStack
                }

                NavigationLink(
                    destination: AddPlantSecondStepView(input: value()),
                    label: {
                        Text("Choose Location")
                    }
                )
                .bold()
                .frame(width: 280, height: 50)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(50)

            }.padding(.horizontal)

        }.ignoresSafeArea()
    }

    func value() -> AddPlantFirstStepViewOutput {
        return AddPlantFirstStepViewOutput(
            startLocationText: startLocationText,
            destinationLocationText: destinationLocationText,
            startDate: startDate,
            endDate: endDate
        )
    }
}

struct ChooseLocationModalView: View {
    @StateObject private var viewModel = AddPlanViewModel()
    @Binding var isPresented: Bool

    var didChooseLocation: (CLLocationCoordinate2D) -> ()

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(
                coordinateRegion: $viewModel.region,
                showsUserLocation: true
            )
            .ignoresSafeArea()
            .tint(.pink)

            VStack {
                LocationButton(.currentLocation) {
                    viewModel.requestAllowOnceLocationPermission()
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
                        self.isPresented.toggle()
                    }, label: {
                        Text("Close")
                    }
                ).padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                Button(
                    action: {
                        self.isPresented.toggle()
                    }, label: {
                        Text("Choose")
                    }
                ).padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct AddPlantSecondStepView: View {
    var input: AddPlantFirstStepViewOutput

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanView()
    }
}
