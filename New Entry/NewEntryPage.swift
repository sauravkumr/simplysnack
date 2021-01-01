//
//  NewEntryPage.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/23/20.
//

import Foundation
import SwiftUI
import RealmSwift
import Firebase

let today = Date()
let formatter1 = DateFormatter()


struct NewEntryView: View{
    @State var title: String = ""
    @State var comment: String = ""
    
    @State var image: UIImage?
    
    @ObservedObject var dataHandler: DataHandler

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
                    
                    TextField("Title...", text: $title).frame(width: 270)
                }
                .frame(width: 296, height: 50)
                Text("Title").font(.headline).bold()
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lightGray, lineWidth: 1)
                    TextField("Notes...", text: $comment).frame(width: 270)
                }
                .frame(width: 296, height: 50)
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    func postToFirebase() {
        let postID = UUID().uuidString
        guard let impageData = image?.jpegData(compressionQuality: 0.1) else{return}
        
        let ref = Storage.storage().reference().child("Posts").child(postID)
            
        ref.putData(impageData , metadata: nil) { (metadata, error) in
            if error == nil{
                ref.downloadURL { (url, error) in
                    if error == nil{
                        
                        let imageHeight = self.image?.size.height ?? 0
                        let imageWidth = self.image?.size.width ?? 0
                        let aspectRatio = Double(imageHeight/imageWidth)
                        
                        Database.database().reference().child("Posts").child(postID).updateChildValues(["imageURL" : url?.absoluteString ?? "", "id" : postID, "aspectRatio" : aspectRatio, "title" : self.title, "date" : Date().iso8601, "comment" : self.comment, "uid" : self.dataHandler.loggedInUser.id, "todayDate": formatter1.string(from: today)])
                        print("OMG NO WAY ITS ACTUALLY WORKIG ANIOSDJAIOLSDJLAK SJD ILAKSJD")
                        
                    }else{
                        print("NOOOOO")
                        //add an alert
                    }
                }
            }else{
                print(error)
                //add an alert
            }
        }
        
    }
}

