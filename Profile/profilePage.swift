//
//  settingsPage.swift
//  Memestagram
//
//  Created by Saurav Kumar on 8/23/20.
//  Copyright © 2020 Saurav Kumar. All rights reserved.
//

import Foundation
import SwiftUI

var yellow = Color(red: 255 / 255, green: 199 / 255, blue: 0 / 255)
var lightGray = Color(red: 218 / 255, green: 218 / 255, blue: 218 / 255)

struct ProfileView: View{
    var body: some View{
        NavigationView{
            VStack(spacing: 0){
                VStack{
                    //profile image
                    Image("ProfileImage-test")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140, alignment: .center)
                        .cornerRadius(70)
                        .clipped()
                    
                    //profile name
                    Text("Saurav Kumar").font(.callout)
                    VStack(spacing: 0){
                        HStack(spacing: 0){
                            
                            VStack{
                                Image(systemName: "square.grid.2x2.fill").resizable().frame(width: 30, height: 30).foregroundColor(yellow)
                                
                                Rectangle()
                                    .fill(yellow)
                                    .frame(width: UIScreen.main.bounds.width, height: 5)

                            }
                        }
                        
                    }
                }.padding(.bottom, 0)
                //make spacing for this VStack 0
                ContentView2()
                Spacer()
            }.navigationTitle("Profile")
        }
        
    }
}


struct profilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct Items: Identifiable {
    let id = UUID()
    let name: String
}

struct ContentView2: View {
    let array = [ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(), ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView(),ImageView()]

    var body: some View {
        QGrid(array, columns: 3, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0) { post in
            post.image.aspectRatio(contentMode: .fill).frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3, alignment: .center).clipped()
        }
    }
}

struct ImageView: Identifiable{
    var id = UUID()
    var image = Image("pizza").resizable()
}

struct MyCell: View {
    let item: Items

    var body: some View {
        Text("\(item.name)")
    }
}
