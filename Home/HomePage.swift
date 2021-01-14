//
//  HomePage.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/23/20.
//

import Foundation
import SwiftUI

struct HomeView: View{
    var body: some View{
        NavigationView{
            VStack(alignment: .leading, spacing: 0){
                VStack(alignment: .leading){
                    Text("Today").font(.title2).fontWeight(.bold)
                    ZStack(alignment: .leading){
                    //Rectangle 29
                        RoundedRectangle(cornerRadius: 20)
                        .fill(lightGray)
                        .frame(width: 225, height: 12)
                    //Rectangle 30
                        RoundedRectangle(cornerRadius: 20)
                        .fill(yellow)
                        .frame(width: 160, height: 12)

                    }
                    Text("6 entries logged").font(.caption).multilineTextAlignment(.center)
                }
                HStack{
                    //download-1 6
                    Image("pizza")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 139, height: 139)
                        .cornerRadius(20)
                        .overlay(Text("1:30 PM").font(.title3).fontWeight(.bold).foregroundColor(.white))
                    Spacer()
                    Image("boba")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 139, height: 139)
                        .cornerRadius(20)
                        .overlay(Text("11:56 AM").font(.title3).fontWeight(.bold).foregroundColor(.white))
                }.padding()
                HStack{
                    //download-1 6
                    Image("oatmeal")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 139, height: 139)
                        .cornerRadius(20)
                        .overlay(Text("10:29 AM").font(.title3).fontWeight(.bold).foregroundColor(.white))
                    Spacer()
                    Image("pizza")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 139, height: 139)
                        .cornerRadius(20)
                        .overlay(Text("12:48 AM").font(.title3).fontWeight(.bold).foregroundColor(.white))
                }.padding()

                Spacer()
            }.padding()
            .navigationTitle("Home")
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
