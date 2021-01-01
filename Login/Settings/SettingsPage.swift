//
//  SettingsPage.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 11/27/20.
//

import Foundation
import SwiftUI
import Firebase
import RealmSwift
import SDWebImageSwiftUI
import WebKit

struct SettingsView : View {
    @Environment(\.openURL) var openURL
    
    @ObservedObject var dataHandler : DataHandler
    @Binding var isLoggedIn : Bool
    @Binding var doesRealmExist: Bool
    
    @State var isPresented : Bool = false
    @State var image : Image?
    @State var uiImage : UIImage?
    @State var username : String = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    HStack {
                        if self.image != nil {
                            self.image!.resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 100, alignment: .center).clipped().cornerRadius(50)
                        } else {
                            if dataHandler.loggedInUser.profileImageURL == "" {
                                Image(systemName: "person.circle.fill").resizable().foregroundColor(Color.gray).aspectRatio(contentMode: .fill).frame(width: 100, height: 100, alignment: .center).clipped().cornerRadius(50)
                            } else {
                                WebImage(url: URL(string: dataHandler.loggedInUser.profileImageURL)).resizable().foregroundColor(Color.gray).aspectRatio(contentMode: .fill).frame(width: 100, height: 100, alignment: .center).clipped().cornerRadius(50)
                            }
                        }
                        Spacer()
                        Button(action: self.choosePhoto, label: {
                            Text("Choose Photo").foregroundColor(.black).font(.headline)
                        })
                        Spacer()
                    }.padding()
                    TextField("New username...", text: self.$username, onEditingChanged: {
                        changed in
                    }, onCommit: {
                        self.submitNewUsername()
                    }).padding()
                    Button(action: self.submit, label: {Text("Submit").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)}).background(yellow).cornerRadius(10).padding()
                    Spacer()
                    Button(action: self.logOut, label: {Text("Logout").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)}).background(Color.red).cornerRadius(10).padding()
                    //                    .padding(.bottom, 30)
                    Divider()
                    Button(action: {openURL(URL(string: "https://forms.gle/dEH8VYRHGF2CxKz7A")!)}, label: {
                        Text("Report a Bug").foregroundColor(Color.black)
                        
                    }).padding()
                    Button(action: {openURL(URL(string: "https://forms.gle/5B53pwPaS5camTNh8")!)}, label: {
                        Text("Contact Us").foregroundColor(Color.black)
                    }).padding()
                    Spacer()
                }
                .sheet(isPresented: self.$isPresented, content: {
                    ImagePicker(isShown: self.$isPresented, image: self.$image, uiImage: self.$uiImage)
                })
                .navigationTitle("Settings")
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    func submitNewUsername() {
        if username != "" {
            Database.database().reference().child("users").child(self.dataHandler.loggedInUser.id).updateChildValues(["username" : self.username])
            try! uiRealm.write({
                self.dataHandler.loggedInUser.username = self.username
            })
            print("username changed")
            self.username = ""
        } else {
            //alert
        }
    }
    
    func logOut() {
        self.isLoggedIn = false
        self.doesRealmExist = false
        self.dataHandler.HomePagePosts.removeAll()
        try! Auth.auth().signOut()
        do {
            try! uiRealm.write({
                uiRealm.deleteAll()
            })
            Thread.callStackSymbols.forEach{print($0)}
        }
    }
    
    func submit() {
        
        guard let imageData = uiImage?.jpegData(compressionQuality: 0.1) else{return}
        
        let ref = Storage.storage().reference().child("users").child(self.dataHandler.loggedInUser.id)
        
        ref.putData(imageData , metadata: nil) { (metadata, error) in
            if error == nil{
                ref.downloadURL { (url, error) in
                    if error == nil{
                        
                        Database.database().reference().child("users").child(self.dataHandler.loggedInUser.id).updateChildValues(["profileImage" : url?.absoluteString ?? ""])
                        try! uiRealm.write({
                            self.dataHandler.loggedInUser.profileImageURL = url?.absoluteString ?? ""
                        })
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
        
        //        guard let imageData = uiImage?.jpegData(compressionQuality: 0.1) else {return}
        //        let ref = Storage.storage().reference().child("users").child(self.dataHandler.loggedInUser.id)
        //        ref.putData(imageData, metadata: nil) { (metadata, error) in
        //            if error == nil {
        //                ref.downloadURL { (url, error) in
        //                    if error == nil {
        //                        Database.database().reference().child("users").child(self.dataHandler.loggedInUser.id).updateChildValues(["profileImage" : url?.absoluteString ?? ""])
        //
        //                        try! uiRealm.write({
        //                            self.dataHandler.loggedInUser.profileImageURL = url?.absoluteString ?? ""
        //                        })
        //                    }
        //                }
        //            } else {
        //                print(error)
        //            }
        //        }
    }
    
    func choosePhoto() {
        self.isPresented.toggle()
    }
}
