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
    //  To Access Plans and save them
    @EnvironmentObject var viewModel: PlanViewModel
    //  To Access Campsites to show on map
    @EnvironmentObject var locationViewModel: LocationViewModel

    @State private var isStartLocationModalOpen = false
    @State private var isDestinationLocationModalOpen = false
    @State private var isStartDatePickerVisible = false
    @State private var isEndDatePickerVisible = false
    @State var startLocation: CLLocationCoordinate2D?
    @State var destinationLocation: CampingSite?
    @State private var startDate: Date = .today
    @State private var endDate: Date = .tomorrow
    @State private var dateFormatter = formatter()
    @State private var annotations: [CampingSiteData] = []

    var completed: () -> ()

    var body: some View {
        VStack {
            HeaderView()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Start location")
                    Button(
                        action: {
                            self.isStartLocationModalOpen.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "location")
                                Text(startLocation == nil ? "Start location" : "Chosen on the map")
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
                        AddPlanChooseStartLocationModalView(
                            isPresented: self.$isStartLocationModalOpen
                        ) {
                            location in
                            startLocation = location
                        }
                    }.padding(.bottom)

                    VStack(alignment: .leading) {
                        Text("Destination location")
                        Button(
                            action: {
                                self.isDestinationLocationModalOpen.toggle()
                            }, label: {
                                HStack {
                                    Image(systemName: "location")
                                    Text(destinationLocation?.name ?? "Destination location")
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
                            AddPlanChooseDestinationLocationModalView(
                                isPresented: self.$isDestinationLocationModalOpen
                            ) {
                                campingSite in
                                destinationLocation = campingSite
                            }
                        }.padding(.bottom)

                        Text("Start Date")
                        Button(
                            action: {
                                self.isStartDatePickerVisible.toggle()
                            }, label: {
                                HStack {
                                    Image(systemName: "location")
                                    Text(
                                        dateFormatter.string(from: startDate)
                                    )
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
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .labelsHidden()
                            .datePickerStyle(.graphical)

                            Button(
                                action: {
                                    self.isStartDatePickerVisible.toggle()
                                }, label: {
                                    Text("Close")
                                }
                            )
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .padding(.bottom)
                        }
                    }

                    VStack(alignment: .leading) {
                        Text("End Date")
                        Button(
                            action: {
                                self.isEndDatePickerVisible.toggle()

                            }, label: {
                                HStack {
                                    Image(systemName: "location")
                                    Text(
                                        dateFormatter.string(from: endDate)
                                    )
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
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .labelsHidden()
                            .datePickerStyle(.graphical)

                            Button(
                                action: {
                                    self.isEndDatePickerVisible.toggle()
                                }, label: {
                                    Text("Close")
                                }
                            )
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .padding(.bottom)
                        }
                    }

                    VStack(alignment: .leading) {
                        NavigationLink(
                            destination: AddPlanOverview(completed: {
                                completed()
                            }, input: value())
                            .environmentObject(PlanViewModel()),
                            label: {
                                Text("Create trip")
                            }
                        )

                        .bold()
                        .frame(width: 280, height: 50)
                        .background(submitButtonBackground)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .disabled(!isFormValid)
                    }.padding([.bottom], 50)
                    // Extra arguments in call =  Maximum number of views in this VStack
                }.padding([.leading, .bottom, .trailing], 60)
            }

        }.ignoresSafeArea()
    }

    var isFormValid: Bool {
        let correctDates = startDate.timeIntervalSince1970 <= endDate.timeIntervalSince1970
        let hasStartLocation = startLocation != nil
        let hasDestinationLocation = destinationLocation != nil

        return correctDates && hasStartLocation && hasDestinationLocation
    }

    var submitButtonBackground: Color {
        return isFormValid ? Color.black : Color.gray
    }

    func value() -> AddPlantFirstStepViewOutput? {
        //  It should be used only when form is validated and fields are filled
        guard let startLocation = startLocation else {
            return nil
        }
        guard let destinationLocation = destinationLocation else {
            return nil
        }

        return AddPlantFirstStepViewOutput(
            startLocation: startLocation,
            destinationLocation: destinationLocation,
            startDate: startDate,
            endDate: endDate
        )
    }

    static func formatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter
    }
}

struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanView {
            print("AddPlanView_Previews: Completed")
        }
        .environmentObject(LocationViewModel())
        .environmentObject(PlanViewModel())
    }
}
