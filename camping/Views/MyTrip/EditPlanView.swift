//
//  EditPlanView.swift
//  camping
//
//  Created by Binod Panta on 23.4.2023.
//

import SwiftUI

struct EditPlanView: View {
    @StateObject var viewModel = MyTripViewModel(context: PersistenceController.shared.container.viewContext)
    @State var planDetail: PlanDetail
    @State private var isStartDatePickerVisible = false
    @State private var isEndDatePickerVisible = false
    @State private var dateFormatter = formatter()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        VStack{
            ZStack(alignment: .top) {
                if let imageURLString = planDetail.imageURL, let imgURL = URL(string: imageURLString) {
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
                    Text("Edit Plan")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top,55)
                    
                }
            } .ignoresSafeArea()
         
            HStack{
                VStack{
                    Text(planDetail.destination.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                }
                Image(systemName: "tent")
            }
            .padding(.top,-60)
            Spacer()
            
            ScrollView{
                VStack(alignment: .leading){
                    Text("Start Date")
                    Button(
                        action: {
                            self.isStartDatePickerVisible.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "location")
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
                    
                    
                    VStack(alignment: .leading) {
                        Text("End Date")
                        Button(
                            action: {
                                self.isEndDatePickerVisible.toggle()
                                
                            }, label: {
                                HStack {
                                    Image(systemName: "location")
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
                        Spacer()
                        Button("Save Changes") {
                            
                            // Save changes and dismiss the view
                            viewModel.editPlan(planDetail: planDetail, startDate: planDetail.start, endDate: planDetail.end)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                    }.padding([.bottom], 50)
                        
                        
                    }
                }
                .padding([.leading, .bottom, .trailing], 60)
            }
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
