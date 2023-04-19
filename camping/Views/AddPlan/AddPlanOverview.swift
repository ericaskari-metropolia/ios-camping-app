//
//  AddPlanOverview.swift
//  camping
//
//  Created by Eric Askari on 14.4.2023.
//

import MapKit
import SwiftUI

struct AddPlanOverview: View {
    @Environment(\.dismiss) var dismiss
    //  To Access Plans and save them
    @EnvironmentObject var viewModel: PlanViewModel

    @State private var saved = false
    var span: CLLocationDegrees = 0.01

    @State private var snapshotImage: UIImage? = nil

    var completed: () -> ()

    var input: AddPlantFirstStepViewOutput?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack {
                    GeometryReader { geometry in
                        Group {
                            if let image = snapshotImage {
                                Image(uiImage: image)
                                    .frame(height: 300)
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
                            self.generateSnapshot(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(Color.red)

                
                Text(self.input?.startDate.description ?? "No Start date")
                Text(self.input?.endDate.description ?? "No End date")
                Text(self.input?.startLocation.latitude.description ?? "No Start latitude")
                Text(self.input?.startLocation.longitude.description ?? "No Start latitude")
                Text(self.input?.destinationLocation.name ?? "No Destination name")

                Button {
                    self.viewModel.savePlan(input: self.input!)
                    self.saved = true
                    self.completed()
                    self.dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(self.input == nil || self.saved)
            }
            .background(Color.red)
        }.ignoresSafeArea()
    }

    func generateImageUrl(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) {}

    func generateSnapshot(width: CGFloat, height: CGFloat) {
        let coordinate1 = self.input?.startLocation ?? CLLocationCoordinate2D(latitude: 60.192059, longitude: 24.945831)

        let coordinate2 = CLLocationCoordinate2D(latitude: self.input?.destinationLocation.latitude ?? 60.229192, longitude: self.input?.destinationLocation.longitude ?? 24.748633)

        // convert them to MKMapPoint
        let p1 = MKMapPoint(coordinate1)
        let p2 = MKMapPoint(coordinate2)

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

                let point1 = snapshot.point(for: coordinate1)
                let point2 = snapshot.point(for: coordinate2)

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

                    let pinImageCGPoint1 = CGPoint(x: point1.x - pinImage.size.width / 2, y: point1.y - pinImage.size.height / 2)

                    let pinImageCGPoint2 = CGPoint(x: point2.x - pinImage2.size.width / 2, y: point2.y - pinImage2.size.height / 2)

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
