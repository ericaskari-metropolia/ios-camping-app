//
//  EditPlanView.swift
//  camping
//
//  Created by Binod Panta on 23.4.2023.
//

import SwiftUI

struct EditPlanView: View {
    @EnvironmentObject var viewModel: MyTripViewModel

    @State var planDetail: PlanDetail
    @State private var isStartDatePickerVisible = false
    @State private var isEndDatePickerVisible = false
    @State private var dateFormatter = formatter()
    @State private var startDate: Date = .today
    @State private var endDate: Date = .tomorrow
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        VStack{
            ZStack(alignment: .top) {
                if  let imgURL = URL(string: planDetail.imageURL) {
                    //create an AsyncImage with the URL
                    AsyncImage(url: imgURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        // if the image is still loading, show a ProgressView
                        ProgressView()
                    }
                }
                VStack{
                    Text("label.editPlan".i18n())
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top,55)
                    
                }
            }
            
            .ignoresSafeArea()
            VStack{
                HStack{
                    Label("label.editStatus".i18n(), systemImage: "pencil.circle.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 40)
                        .background(Color.cyan)
                        .cornerRadius(15)
                    
                }    
                HStack{
                    VStack(alignment:.leading){
                        Text(planDetail.destination.name ?? "label.destinationlocation".i18n())
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    Image(systemName: "tent")
                }
                .padding()
            }
            .padding(.bottom, 40)
            .padding(.top,-80)
            
            Spacer()
            
            ScrollView(){
                VStack(alignment: .leading){
                    Text("label.startdate".i18n())
                    Button(
                        action: {
                            self.isStartDatePickerVisible.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "clock")
                                Text(
                                    dateFormatter.string(from: planDetail.start)
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
                            selection: $planDetail.start,
                            in: Date.today...,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                        
                        Button(
                            action: {
                                self.isStartDatePickerVisible.toggle()
                            }, label: {
                                Text("action.close".i18n())
                            }
                        )
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .padding(.bottom)
                        .padding(.top, -20)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("label.enddate".i18n())
                        Button(
                            action: {
                                self.isEndDatePickerVisible.toggle()
                                
                            }, label: {
                                HStack {
                                    Image(systemName: "clock")
                                    Text(
                                        dateFormatter.string(from: planDetail.end)
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
                                selection: $planDetail.end,
                                in: Date.today...,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .labelsHidden()
                            .datePickerStyle(.graphical)
                            
                            Button(
                                action: {
                                    self.isEndDatePickerVisible.toggle()
                                }, label: {
                                    Text("action.close".i18n())
                                }
                            )
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .padding(.top, -20)
                            .padding(.bottom)
                        }
                        Spacer()
                        Button("btn.saveChanges".i18n()) {
                            
                            // Save changes and dismiss the view
                            viewModel.editPlan(planDetail: planDetail, startDate: planDetail.start, endDate: planDetail.end)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(submitButtonBackground)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .padding(.leading,15)
                        .disabled(!isFormValid)
                    }.padding([.bottom], 50)
                    
                    
                }
                .padding([.leading, .bottom, .trailing], 40)
            }
            
            
            .padding(.top,-55)
            .ignoresSafeArea()
            
        }
    }
    
    var isFormValid: Bool {
        let correctDates = planDetail.start.timeIntervalSince1970 <= planDetail.end.timeIntervalSince1970
        return correctDates
    }
    
    var submitButtonBackground: Color {
        return isFormValid ? Color.black : Color.gray
    }
    
}


func formatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm E, d MMM y"
    return formatter
}


//struct EditPlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPlanView()
//    }
//}
