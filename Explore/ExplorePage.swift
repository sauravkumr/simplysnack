//
//  ExplorePage.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/24/20.
//

import Foundation
import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct ExploreView: View{
    var body: some View{
        NavigationView{
            VStack(alignment: .leading){
                NavigationLink(destination: webView(url: "https://spoonacular.com/recipes/\(model[0].title.removeWhitespace())-\(model[0].id)").onAppear(perform: {
//                    showTabBar = false
                }).onDisappear(perform: {
                        showTabBar = true
                    }).buttonStyle(TestButtonStyle())){
                    SnapCarousel(UIState: UIState).buttonStyle(TestButtonStyle()).frame(height: 300)
                    
                }
                .onTapGesture{
                        showTabBar = false
                    }
                .buttonStyle(TestButtonStyle())
                .padding(.top, 50)
                
                
                Spacer()
                
                
                
            }.navigationTitle("Explore")
            
            
        }
    }
}

struct ExplorePage_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

struct TestButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
//            .padding(6)
//            .foregroundColor(Color.white)
//            .background(Color.blue)
//            .cornerRadius(100)
//            .shadow(color: .black, radius: self.focused ? 20 : 0, x: 0, y: 0) //  0

    }
}

