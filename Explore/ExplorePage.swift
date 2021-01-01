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
    @Environment(\.openURL) var openURL
    
    @State var modelURL: String = ""
    
    var body: some View{
        NavigationView{
            VStack(alignment: .center){
//                NavigationLink(destination: webView(url: modelURL).buttonStyle(TestButtonStyle())){
                    SnapCarousel(UIState: UIState, modelURL: self.$modelURL).buttonStyle(TestButtonStyle()).frame(height: 300)
                    
//                }
                //                .onTapGesture{
                //                    showTabBar = false
                //                }
                .buttonStyle(TestButtonStyle())
                .padding(.top, 50)
//                Text("Categories").font(.title).bold()
                VStack(alignment: .center){
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
//                            recipeCategory(name: "Holiday Meals", image: "holidayFood", url: "https://tasty.co/feature/holiday-cooking")
                            recipeCategory(name: "Snacks", image: "snack", url: "https://www.allrecipes.com/recipes/17146/appetizers-and-snacks/snacks/?internalSource=hubcard&referringContentType=Search&clickId=cardslot%201")
                            recipeCategory(name: "Breakfast", image: "breakfast", url: "https://www.allrecipes.com/recipes/78/breakfast-and-brunch/")
                            recipeCategory(name: "Lunch", image: "lunch", url: "https://www.allrecipes.com/recipes/17561/lunch/")
                            recipeCategory(name: "Dinner", image: "dinner", url: "https://www.allrecipes.com/recipes/17562/dinner/")
                            recipeCategory(name: "Dessert", image: "dessert", url: "https://www.allrecipes.com/recipes/79/desserts/")
                        }
                        .padding()
                    }.frame(width: UIScreen.main.bounds.width - 60, height: 100, alignment: .center)
                    Spacer()
                }.padding()
                Spacer()
                
                
                
            }.navigationTitle("Explore")
            .onAppear() {
                print(model[3].url)
            }
            
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct recipeCategory: View {
    @Environment(\.openURL) var openURL
    
    var name: String
    var image: String
    var url: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(self.image).resizable().aspectRatio(contentMode: .fill).frame(width: 120, height: 120).clipped().cornerRadius(20).overlay(
                ZStack{
                    Rectangle().frame(width: 120, height: 120).foregroundColor(Color.black.opacity(0.3)).cornerRadius(20)
                    Text(self.name).font(.title3).foregroundColor(Color.white).bold().frame(width: 100).multilineTextAlignment(.center)
                }).shadow(radius: 5)
        }.onTapGesture {
            openURL(URL(string: self.url)!)
        }
    }
}

struct TestButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
    }
}

