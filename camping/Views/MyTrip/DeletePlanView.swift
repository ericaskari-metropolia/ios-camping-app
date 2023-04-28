//
//  DeletePlanView.swift
//  camping
//
//  Created by The Minions on 24.4.2023.
//

import SwiftUI

struct DeletePlanView: View {
    @State var planDetail: PlanDetail
    @EnvironmentObject var viewModel: MyTripViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                if let imgURL = URL(string: planDetail.imageURL) {
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
                
            }
            .ignoresSafeArea()
            HStack{
                Label("label.deleteStatus".i18n(), systemImage: "trash.circle")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 40)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(15)
                
            }
            .padding(.top,-80)
            Text("label.planInfo".i18n())
                .padding()
                .padding(.top, -25)
                .foregroundColor(Color("PrimaryColor"))
            VStack{
                
                HStack{
                    Text(planDetail.destination.name ?? "")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryColor"))
                    Spacer()
                    Image(systemName: "tent")
                }
                .padding(.bottom, -15)
                .padding()
                
                Divider()
                    .padding(.vertical,5)
                    .frame(height:1)
                    .background(Color.black.opacity(0.1))
                
                
                HStack{
                    Label("\(planDetail.start.displayFormat) - \(planDetail.end.displayFormat)", systemImage:"calendar")
                        .font(.caption)
                        .foregroundColor(Color("PrimaryColor"))
                    
                    
                    Spacer()
                    Image(systemName: "note.text")
                }
                .padding(.vertical, -15)
                .padding()
            }
            
            .background(RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2))
            .padding(.top,10)
            .padding(.horizontal,5)
            
            Divider()
            Text("label.deleteAlert".i18n())
                .font(.title3)
                .foregroundColor(Color("PrimaryColor"))
                .padding(.horizontal,2)
                .padding(.vertical,10)
            HStack {
                Button("btn.cancel".i18n()) {
                    dismiss()
                }
                .padding()
                .foregroundColor(.white)
                .frame(width: 100, height: 50)
                .background(Color("PrimaryColor"))
                .cornerRadius(15)
                
                Button("btn.delete".i18n()) {
                    deletePlan()
                    dismiss()
                }
                .foregroundColor(.white)
                .frame(width: 100, height: 50)
                .background(Color.red)
                .cornerRadius(15)
            }
            Spacer()
            
        }
    }
    func deletePlan() {
        viewModel.deletePlan(planDetail)
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

extension DeletePlanView {
    var deleteButton: some View {
        Label("btn.delete".i18n(), systemImage: "trash")
            .foregroundColor(.white)
            .frame(width: 350, height: 50)
            .background(Color.black)
            .cornerRadius(15)
    }
}
