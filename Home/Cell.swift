//
//  Cell.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/23/20.
//

import Foundation
import SwiftUI
import WebKit
import SDWebImageSwiftUI
import Firebase

struct EntryCell: View{
    var currentPost: Post
    @State var fullPost = false
    //    var image: String
    
    var body: some View{
        ZStack{
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width - 30, height: 150)
                .shadow(radius: 7)
            HStack{
                WebImage(url: URL(string: self.currentPost.imageURL), options: .highPriority, context: nil)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .cornerRadius(20)
                VStack(alignment: .leading){
                    Text(self.currentPost.title).font(.headline).fontWeight(.bold).foregroundColor(Color.black)
                    Text(self.currentPost.date?.formatDate() ?? "").font(.caption).foregroundColor(Color.gray)
                }.padding(.leading, 20)
                .frame(width: UIScreen.main.bounds.width - 200)
                Spacer()
            }.padding(.leading, 25)
            Spacer()
        }.onTapGesture {
            self.fullPost.toggle()
        }
        .sheet(isPresented: self.$fullPost, content: {
//            WebImage(url: URL(string: self.currentPost.imageURL), options: .highPriority, context: nil).resizable().aspectRatio(contentMode: .fit)
//            FullPostCell(image: self.currentPost.imageURL, date: self.currentPost.date?.formatDate() ?? "", description: self.currentPost.comment, title: self.currentPost.title)
        })
    }
}

struct FullPostCell: View{
    @ObservedObject var dataHandler: DataHandler
    
    var image: String
    var date: String
    var description: String
    var title: String
    var currentPost: Post

    
    @State var bigLogOut = false
    @State var showAlert = false

    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            WebImage(url: URL(string: self.image), options: .highPriority, context: nil)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
                .clipped()
            
            HStack{
                VStack{
                    Text(title).bold().font(.title).multilineTextAlignment(.leading).frame(width: 2 * UIScreen.main.bounds.width/3, alignment: .leading)
                    Text(date).font(.caption).foregroundColor(Color.gray).frame(width: 2 * UIScreen.main.bounds.width/3, alignment: .leading)
                }
//                .padding(.leading)

                Spacer()
                
                if dataHandler.loggedInUser.profileImageURL == "" {
                    Image(systemName: "folder.circle.fill").resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70, alignment: .center)
                        .cornerRadius(70)
                        .clipped()

                } else {
                    WebImage(url: URL(string: dataHandler.loggedInUser.profileImageURL)).resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70, alignment: .center)
                        .cornerRadius(70)
                        .clipped()
                }

            }.padding()
            
            Text(description).font(.footnote).foregroundColor(Color.gray).padding(.horizontal, 10)
            
            Spacer()
            
//            if bigLogOut == false {
            HStack(alignment: .center) {
                Spacer()
                Button(action: {
                    self.deletePost()
                }, label: {
                        Text("Delete Post").foregroundColor(.red)
                            .frame(width: 200, height: 100, alignment: .center)

                    })
                Spacer()
            }

//            } else {
//                ZStack{
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 200, height: 100, alignment: .center)
//                    Text("Delete Post")
//                }

//            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Delete Post"), message: Text("This action is irreversible"),
                  primaryButton: .default (Text("Delete")) {
                    Database.database().reference().child("Posts").child("\(currentPost.id)").removeValue()
                },
                secondaryButton: .cancel()
            )
        }
    }
    func deletePost() {
        showAlert.toggle()
        print(currentPost.id)
    }
}
