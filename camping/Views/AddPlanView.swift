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
    @State var startLocationText: String = ""
    @State var destinationLocationText: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @StateObject private var viewModel = AddPlanViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Button(
                    action: {
                        self.isStartLocationModalOpen.toggle()
                    }, label: {
                        Text("Start location")
                    }
                )
                .bold()
                .frame(width: 280, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $isStartLocationModalOpen) {
                    ChooseLocationModalView(
                        isPresented: self.$isStartLocationModalOpen
                    ) {
                        coordinates in
                        
                        print(coordinates)
                    }
                }
                
                Button(
                    action: {
                        self.isDestinationLocationModalOpen.toggle()
                    }, label: {
                        Text("Destination location")
                    }
                )
                .bold()
                .frame(width: 280, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $isDestinationLocationModalOpen) {
                    ChooseLocationModalView(
                        isPresented: self.$isDestinationLocationModalOpen
                    ) {
                        coordinates in
                        
                        print(coordinates)
                    }
                }
                
                DatePicker(
                    "Start Date",
                    selection: $startDate,
                    displayedComponents: [.date]
                )
                .padding()
                
                DatePicker(
                    "End Date",
                    selection: $endDate,
                    displayedComponents: [.date]
                )
                .padding()
                
                NavigationLink(
                    destination: AddPlantSecondStepView(input: value()),
                    label: {
                        Text("Choose Location")
                    }
                )
                .bold()
                .frame(width: 280, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
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
