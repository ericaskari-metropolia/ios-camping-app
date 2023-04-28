//
//  PermissionView.swift
//  camping
//
//  Created by Thu Hoang on 7.4.2023.
//

import Foundation
import SwiftUI
import MapKit

// View to ask permission to get user's location

struct PermissionView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        
        //Display view depends on the authorizationStatus
        switch locationViewModel.authorizationStatus {
            // When the status is not determined, display asking permission view
        case .notDetermined:
            AnyView(RequestLocationView())
                .onAppear{
                    locationViewModel.fetchCampingSites()
                }
            // When the use refused, display error view
        case .denied, .restricted:
            ErrorView()
            // When the use allowed, go to NavigationTabView
        case .authorizedWhenInUse, .authorizedAlways:
            NavigationTabView()
        default:
            Text("Default")
        }
    }
}

// View to ask permission
struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    var body: some View {
        VStack{
            Text("location.request".i18n())
        }
        .onAppear(perform: locationViewModel.requestPermission)
        .navigationBarBackButtonHidden(true)
    }
}

// View when user's is not giving permission to get location
struct ErrorView: View {
    var body: some View {
        VStack{
            Text("location.error".i18n())
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView()
    }
}
