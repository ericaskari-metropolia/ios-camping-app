//
//  AddPlanChooseLocationModalView.swift
//  camping
//
//  Created by The Minions on 13.4.2023.
//

import CoreLocation
import CoreLocationUI
import MapKit
import SwiftUI

struct AddPlanChooseDestinationLocationModalView: View {
    //  To Access Location
    @StateObject var viewModel: LocationViewModel = .init()

    @Binding var isPresented: Bool

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var campingSites: FetchedResults<CampingSite>

    var didChooseLocation: (CampingSite) -> ()

    var body: some View {
        ZStack(alignment: .top) {
            AnnotatedMap(
                region: $viewModel.region,
                campingSites: self.campingSites.map { $0 },
                didChooseCampsite: { n in
                    didChooseLocation(n)
                    self.isPresented.toggle()
                }
            )
            .ignoresSafeArea()
            .tint(.pink)

            ZStack(alignment: .top) {
                VStack {
                    Text("AddPlanChooseDestinationLocationModalView.description".i18n())
                        .multilineTextAlignment(.center)
                }.frame(maxWidth: .infinity).padding()
                    .background(.white)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }.frame(maxWidth: .infinity)
                .padding()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(
                            action: {
                                self.isPresented.toggle()
                            }, label: {
                                Text("action.return".i18n())
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

struct AddPlanChooseDestinationModalView_Previews: PreviewProvider {
    @State var isPresented: Bool = true
    static var previews: some View {
        AddPlanChooseDestinationLocationModalView(
            isPresented: .constant(true)
        ) {
            coordinates in
            print(coordinates)
        }
        .environmentObject(LocationViewModel())
    }
}
