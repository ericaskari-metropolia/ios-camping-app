//
//  PermissionView.swift
//  camping
//
//  Created by Thu Hoang on 7.4.2023.
//

import Foundation
import SwiftUI
import MapKit

struct PermissionView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(locationViewModel)
        case .denied, .restricted:
            ErrorView()
        case .authorizedWhenInUse, .authorizedAlways:
            NavigationTabView()
                .environmentObject(locationViewModel)
        default:
            Text("Default")
        }
    }
}

// view ask permission
struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    var body: some View {
        VStack{
            Text("Request location permission")
            Button {
                locationViewModel.requestPermission()
            } label: {
                Text("Allow permission")
            }

        }
    }
}

// view error
struct ErrorView: View {
    var body: some View {
        VStack{
            Text("Request location error")
        }
    }
}

// view success -> tracking user
struct RequestLocationSuccessView: View {
    var body: some View {
        VStack{
            Text("Request location success")
        }
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView()
    }
}
