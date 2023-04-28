//
//  AddPlanOverview.swift
//  camping
//
//  Created by The Minions on 14.4.2023.
//

import MapKit
import SwiftUI

struct AddPlanOverview: View {
    @Environment(\.dismiss) var dismiss
    //  To Access Plans and save them
    @EnvironmentObject var viewModel: PlanViewModel

    var span: CLLocationDegrees = 0.01

    @State private var snapshotImage: UIImage? = nil

    var savedPlan: Plan?
    var completed: () -> ()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .top) {
                    HStack {
                        
                        // Button to go back previous page
                        Button{
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .padding()
                            
                        }
                        .symbolVariant(.circle.fill)
                        .foregroundStyle(Color("PrimaryColor"), .white)
                        
                        Spacer()
                        
                    }
                    .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
                    
                    GeometryReader { geometry in
                        Group {
                            if let image = snapshotImage {
                                Image(uiImage: image)
                                    .frame(height: 600)
                            } else {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                .background(Color(UIColor.secondarySystemBackground))
                            }
                        }
                        .onAppear {
                            if let savedPlan = savedPlan {
                                if let campingSite = savedPlan.campingSite {
                                    self.generateSnapshot(
                                        width: geometry.size.width,
                                        height: 600,
                                        start: CLLocationCoordinate2D(
                                            latitude: savedPlan.startLatitude,
                                            longitude: savedPlan.startLongitude
                                        ),
                                        end: CLLocationCoordinate2D(
                                            latitude: campingSite.latitude,
                                            longitude: campingSite.longitude
                                        )
                                    )
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 600)
                .background(Color.red)
                Text("You have created your new journey!")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color("PrimaryColor"))
                    .font(.system(size: 26))
                    .bold()
                    .padding()

                HStack {
                    if self.savedPlan != nil {
                        NavigationLink(
                            destination: AddPlanGears(plan: self.savedPlan!),
                            label: {
                                Text("Add gear")
                                    .frame(maxWidth: .infinity)
                            }
                        )
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(30)
                    }

                    Button {
                        self.completed()
                        self.dismiss()
                    } label: {
                        Text("Close")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color("PrimaryColor"))
                    .foregroundColor(Color.white)
                    .cornerRadius(30)
                }.padding()
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                    .font(.title)
                    .padding()
                }
                .symbolVariant(.circle.fill)
                .foregroundStyle(Color("PrimaryColor"), .white)
        )
    }

    func generateImageUrl(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) {}

    func generateSnapshot(width: CGFloat, height: CGFloat, start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) {
        // convert them to MKMapPoint
        let p1 = MKMapPoint(start)
        let p2 = MKMapPoint(end)

        let rectPadding = 70000

        let mapRect = MKMapRect(
            x: fmin(p1.x, p2.x) - Double(rectPadding) / 2,
            y: fmin(p1.y, p2.y) - Double(rectPadding) / 2,
            width: fabs(p1.x - p2.x) + Double(rectPadding),
            height: fabs(p1.y - p2.y) + Double(rectPadding)
        )

        // Map options.
        let mapOptions = MKMapSnapshotter.Options()
        mapOptions.mapRect = mapRect
        mapOptions.size = CGSize(width: width, height: height)

        // Create the snapshotter and run it.
        let snapshotter = MKMapSnapshotter(options: mapOptions)

        snapshotter.start { snapshotOrNil, errorOrNil in
            if let error = errorOrNil {
                print(error)
                return
            }

            if let snapshot = snapshotOrNil {
                let mapImage = snapshot.image

                let point1 = snapshot.point(for: start)
                let point2 = snapshot.point(for: end)

                let finalImage = UIGraphicsImageRenderer(size: mapOptions.size).image { _ in
                    UIColor.white.setFill()

                    let configuration = UIImage.SymbolConfiguration(pointSize: 20)

                    let pinImage = UIImage(
                        systemName: "location.north.circle.fill",
                        withConfiguration: configuration
                    )!
                    let pinImage2 = UIImage(
                        systemName: "tent.circle.fill",
                        withConfiguration: configuration
                    )!

                    let pinImageCGPoint1 = CGPoint(
                        x: point1.x - pinImage.size.width / 2,
                        y: point1.y - pinImage.size.height / 2
                    )

                    let pinImageCGPoint2 = CGPoint(
                        x: point2.x - pinImage2.size.width / 2,
                        y: point2.y - pinImage2.size.height / 2
                    )

                    mapImage.draw(at: .zero)
                    pinImage.draw(at: pinImageCGPoint1)
                    pinImage2.draw(at: pinImageCGPoint2)
                }
                self.snapshotImage = finalImage
            }
        }
    }
}

struct AddPlanOverview_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanOverview {
            print("AddPlanOverview_Previews: Completed")
        }
        .environmentObject(PlanViewModel())
    }
}
