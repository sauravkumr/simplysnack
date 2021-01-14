//
//  NewEntryPage.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/23/20.
//

import Foundation
import SwiftUI

struct NewEntryView: View{
    @State var username: String = ""

    @State var image: UIImage?
    
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    if image != nil{
                        Image(uiImage: image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 130)
                            .cornerRadius(20)
                    } else{
                        Image("pizza")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 130)
                            .cornerRadius(20)
                    }
                    
                    Spacer()
                    Text("Thumbnail").font(.title2).fontWeight(.bold)
                    Spacer()
                }.padding(.top, 50)
                .padding(.bottom, 50)
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lightGray, lineWidth: 1)
                    
                    TextField("Title...", text: $username).frame(width: 270)
                }
                .frame(width: 296, height: 50)
                Text("Title").font(.headline).bold()
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lightGray, lineWidth: 1)
//                    TextField("Enter username...")
                    
                }
                .frame(width: 296, height: 100)
                Text("Description").font(.headline).bold()
                Button {
                    postToFirebase()
                } label: {
                    ZStack {

                    //Rectangle 40
                        RoundedRectangle(cornerRadius: 20)
                        .fill(yellow)
                        .frame(width: 110, height: 55)
                        
                        //Post
                        Text("Post").font(.title2).bold().foregroundColor(Color.white).multilineTextAlignment(.center).padding()
                    }
                }

                
                Spacer()
            }.navigationTitle("New Entry")
        }
    }
}

func postToFirebase() {
    
}
