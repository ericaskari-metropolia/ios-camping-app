//
//  OnBoardView.swift
//  camping
//
//  Created by Binod Panta on 6.4.2023.
//
import SwiftUI

//Model for the OnBoard items
struct OnBoardItem {
    let image: String
    let title: String
    let description: String
}


//An array containing the contents of onboarditems
private let onBoardItems = [
    OnBoardItem(image:"promo6", title:"Come and explore", description: "Escape to the great outdoors with us"),
    OnBoardItem(image: "promo5", title: "Adventure of lifetime", description: "Experience nature like never before"),
    OnBoardItem(image:"promo3", title: "Pack small, pack smart.", description: "Take only memories. leave only footprints.")
]

struct OnBoardView: View {
    
    //Initial state of the page
    @State private var currentStep = 0
    @State private var isFinishOnboarding = false
    @State private var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    //UI logic for the onboard screen
    var body: some View {
        NavigationView {
            if hasCompletedOnboarding {
                NavigationLink(destination: PermissionView(), isActive: $hasCompletedOnboarding) {
                    EmptyView()
                }
            } else {
                ZStack{
                    Image(onBoardItems[currentStep].image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        TabView(selection: $currentStep) {
                            ForEach(0..<3) { item in
                                VStack{
                                    Spacer()
                                    Text(onBoardItems[item].title)
                                        .font(.title)
                                        .bold()
                                        .padding(.horizontal,40)
                                    
                                    Text(onBoardItems[item].description)
                                        .multilineTextAlignment(.center)
                                }
                                .foregroundColor(.white)
                                .tag(item)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
                        HStack{
                            ForEach(0..<3) { item in
                                if item == currentStep {
                                    Rectangle()
                                        .frame(width: 20,height: 10)
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                } else {
                                    Circle()
                                        .frame(width: 10, height:10)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        Button(action:{
                            if self.currentStep < onBoardItems.count - 1 {
                                self.currentStep += 1
                            } else {
                                
                                //Get started logic
                                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                                hasCompletedOnboarding = true
                            }
                        }){
                            Text( currentStep < onBoardItems.count - 1 ? "Next" : "Get Started")
                                .font(.headline)
                                .padding(16)
                                .background(Color.black)
                                .cornerRadius(16)
                                .padding(.horizontal, 16)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }.background(Color(UIColor(red: 245/255, green: 246/255, blue: 245/255, alpha: 1.0)))
            }
        }
    }
}
struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView()
    }
}
