//
//  AddPlantFirstStepView.swift
//  camping
//
//  Created by The Minion on 3.4.2023.
//

import CoreLocation
import CoreLocationUI
import MapKit
import SwiftUI

struct AddPlanView: View {
    @Environment(\.dismiss) var dismiss
    
    //  To Access Plans and save them
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    // Disable Destination Form Field (Allowed to be passed from parent)
    @State var isDestinationLocationPassedFromParent = false
    
    // Disable/Enable Dismiss when pressed on close from Overview (Allowed to be passed from parent)
    @State var dismissOnAppearEnabled = true
    
    //  State of Modal
    @State private var isStartLocationModalOpen = false
    //  State of Modal
    @State private var isDestinationLocationModalOpen = false
    //  State of DatePicker
    @State private var isStartDatePickerVisible = false
    //  State of DatePicker
    @State private var isEndDatePickerVisible = false
    
    //  State of Form Field
    @State private var dismissOnAppear: Bool = false
    //  State of Form Field
    @State private var startDate: Date = .today
    //  State of Form Field
    @State private var endDate: Date = .tomorrow
    //  State of Form Field
    @State private var dateFormatter = formatter()
    //  State of Form Field
    @State private var startLocation: CLLocationCoordinate2D?
    //  State of Form Field (Allowed to be passed from parent)
    @State var destinationLocation: CampingSite?
    
    // Output
    @State var savedPlan: Plan?
    
    var completed: () -> ()
    
    var body: some View {
        VStack {
            HeaderView(title: "Add plan")
                .ignoresSafeArea()
                .padding(.bottom,-40)
            
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
                        .disabled(isDestinationLocationPassedFromParent)
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
                                in: Date.today...,
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
                                in: Date.today...,
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
                            destination: AddPlanOverview(
                                savedPlan: savedPlan,
                                completed: {
                                    if dismissOnAppearEnabled {
                                        self.dismissOnAppear = true
                                    }
                                    completed()
                                }
                            ),
                            label: {
                                Text("Create trip")
                            }
                        )
                        .simultaneousGesture(TapGesture().onEnded {
                            let formOutput = getFormOutput()
                            
                            if isFormValid {
                                if savedPlan == nil {
                                    savedPlan = planViewModel.savePlan(input: formOutput!)
                                }
                            }
                        })
                        
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
            
        }
        .onAppear {
            reset(
                resetDestinationLocation: !isDestinationLocationPassedFromParent
            )
            
            if dismissOnAppearEnabled && dismissOnAppear {
                dismissOnAppear = false
                dismiss()
            }
        }
    }
    
    var isFormValid: Bool {
        let correctDates = startDate.timeIntervalSince1970 <= endDate.timeIntervalSince1970
        let hasStartLocation = startLocation != nil
        let hasDestinationLocation = destinationLocation != nil
        
        return correctDates && hasStartLocation && hasDestinationLocation
    }
    
    var submitButtonBackground: Color {
        return isFormValid ? Color("PrimaryColor") : Color.gray
    }
    
    func getFormOutput() -> NewPlan? {
        //  It should be used only when form is validated and fields are filled
        guard let startLocation = startLocation else {
            return nil
        }
        guard let destinationLocation = destinationLocation else {
            return nil
        }
        return NewPlan(
            startLocation: startLocation,
            destinationLocation: destinationLocation,
            startDate: startDate,
            endDate: endDate
        )
    }
    
    // Reset Form Function
    func reset(
        resetSavedPlan: Bool = true,
        resetStartLocation: Bool = true,
        resetDestinationLocation: Bool = true,
        resetStartDateLocation: Bool = true,
        resetEndDateLocation: Bool = true
    ) {
        
        if resetSavedPlan {
            print("[AddPlanView] reset savedPlan")
            savedPlan = nil
        }
        if resetStartLocation {
            print("[AddPlanView] reset startLocation")
            startLocation = nil
        }
        if resetDestinationLocation {
            print("[AddPlanView] reset destinationLocation")
            destinationLocation = nil
        }
        if resetStartDateLocation {
            print("[AddPlanView] reset startDate")
            startDate = Date.today
        }
        if resetEndDateLocation {
            print("[AddPlanView] reset endDate")
            endDate = Date.tomorrow
        }
    }
    
    // Date Formatter for fields
    static func formatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter
    }
}

struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanView {
            print("[AddPlanView_Previews]: Completed")
        }
        .environmentObject(LocationViewModel())
        .environmentObject(PlanViewModel())
    }
}
