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


struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Campsite: Identifiable, Codable {
    var id: String
    var name: String
    var latitude: Double
    var longitude: Double
}

struct AddPlantFirstStepViewOutput {
    var startLocationText: String
    var destinationLocationText: String
    var startDate: Date
    var endDate: Date
}

struct AddPlan: View {
    @State private var isStartLocationModalOpen = false
    @State private var isDestinationLocationModalOpen = false
    @State var startLocationText: String = ""
    @State var destinationLocationText: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @StateObject private var viewModel = ContentViewModel()

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
    @StateObject private var viewModel = ContentViewModel()
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

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region: MKCoordinateRegion = .init(
        center: CLLocationCoordinate2D(latitude: 40, longitude: 120),
        span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
    )
    let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestAllowOnceLocationPermission() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            return
        }

        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlan()
    }
}
