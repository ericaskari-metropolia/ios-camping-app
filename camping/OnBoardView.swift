//
//  OnBoardView.swift
//  camping
//
//  Created by Binod Panta on 6.4.2023.
//

import SwiftUI

//The logic not yet added

struct OnBoardItem {
    let image: String
    let title: String
    let description: String
}


private let onBoardItems = [
    OnBoardItem(image:"promo6", title:"Come and explore", description: "Escape to the great outdoors with us"),
    OnBoardItem(image: "promo5", title: "Adventure of lifetime", description: "Experience nature like never before"),
    OnBoardItem(image:"promo3", title: "Pack small, pack smart.", description: "Take only memories. leave only footprints.")
]

struct OnBoardView: View {
    @State private var currentStep = 0
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack{
            Image(onBoardItems[currentStep].image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    Spacer()
                    Image(systemName: "tent")
                    Text("Camplify")
                        .font(.title)
                        .fontWeight(.bold)
                Spacer()
                    Image(systemName: "chevron.right")
                     
                 Spacer()
                } .padding()
                
                
                    
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
                                    .foregroundColor(.purple)
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
                        }
                    }){
                        Text( currentStep < onBoardItems.count - 1 ? "Next" : "Get Started")
                            .font(.headline)
                            .padding(16)
                            .background(Color.purple)
                            .cornerRadius(16)
                            .padding(.horizontal, 16)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            
        }
    }
}
    


struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView()
    }
}
