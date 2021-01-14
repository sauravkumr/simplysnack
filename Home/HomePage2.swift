//
//  HomePage2.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/23/20.
//

import Foundation
import SwiftUI

let impactHeavy = UIImpactFeedbackGenerator(style: .soft)

struct HomeView2: View{
    var body: some View{
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Today").font(.title2).fontWeight(.bold)
                    ZStack(alignment: .leading){
                    //change width of this based on # of entries
                        RoundedRectangle(cornerRadius: 20)
                        .fill(lightGray)
                        .frame(width: 225, height: 12)
                        RoundedRectangle(cornerRadius: 20)
                        .fill(yellow)
                        .frame(width: 160, height: 12)
                        
                    }
                    
                    Text("6 entries logged").font(.caption).multilineTextAlignment(.center)
                    HStack{
                        Spacer()
                    }
                }.padding()
//                https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg
                
                //cell
                EntryCell(image: "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg", title: "Pizza").onTapGesture {
                               impactHeavy.impactOccurred()
                   }
                EntryCell(image: "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg", title: "Pizza").padding(.top).onTapGesture {
                               impactHeavy.impactOccurred()
                   }
                EntryCell(image: "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg", title: "Pizza").padding(.top).onTapGesture {
                               impactHeavy.impactOccurred()
                   }
                EntryCell(image: "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg", title: "Pizza").padding(.top).onTapGesture {
                               impactHeavy.impactOccurred()
                   }
                EntryCell(image: "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg", title: "Pizza").padding(.top).onTapGesture {
                               impactHeavy.impactOccurred()
                   }
                EntryCell(image: "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg", title: "Pizza").padding(.top).onTapGesture {
                               impactHeavy.impactOccurred()
                   }

                Spacer()
            }.navigationTitle("Home")
        }
    }
}

struct HomePage2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
    }
}
