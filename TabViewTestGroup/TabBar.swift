//
//  TabBar.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 12/20/20.
//

import Foundation
import SwiftUI

var showTabBar = true

struct ContentView: View {
    
    @ObservedObject var dataHandler: DataHandler
    @Binding var isLoggedIn : Bool
    @Binding var doesRealmExist: Bool
    
    @State var pickAnImage: Bool = false
    @State var showImagePicker: Bool = false
    @State var showCameraPicker: Bool = false
    @State var image: UIImage?
    
    @ObservedObject var viewRouter = ViewRouter()
    
    @State var showPopUp = false
    
    var body: some View {
        //try to make a navigation view?
        GeometryReader { geometry in
            VStack(spacing: 0){
                Spacer()
                if self.viewRouter.currentView == "home" {
                    //                    HomeView2(dataHandler: dataHandler)
                    HomeView(dataHandler: dataHandler, doesRealmExist: self.$doesRealmExist, isLoggedIn: self.$isLoggedIn)
                } else if self.viewRouter.currentView == "profile" {
                    ProfileView(dataHandler: dataHandler, currentUser: dataHandler.loggedInUser, isLoggedIn: self.$isLoggedIn)
                    //                    , currentUser: dataHandler.loggedInUser
                }
                else if self.viewRouter.currentView == "new-entry" {
                    //                    NavigationLink(destination: NewEntryView(image: self.image))
                    NewEntryView(image: self.image, dataHandler: dataHandler)
                }else if self.viewRouter.currentView == "explore" {
                    ExploreView()
                }else if self.viewRouter.currentView == "settings" {
                    SettingsView(dataHandler: dataHandler, isLoggedIn: self.$isLoggedIn, doesRealmExist: self.$doesRealmExist)
                }
                //POPUP STUFF
                ZStack {
                    if self.showPopUp {
                        HStack(spacing: 50) {
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 70, height: 70)
                                Image(systemName: "camera")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(20)
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.white)
                                
                            }.onTapGesture {
                                self.viewRouter.currentView = "home"
                                print("tapped")
                                self.showCameraPicker.toggle()
                                self.showImagePicker = false
                                self.pickAnImage.toggle()
                                self.showPopUp = false
                                
                            }
                            ZStack {
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 70, height: 70)
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(20)
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.white)
                            }.onTapGesture {
                                self.viewRouter.currentView = "home"
                                self.showImagePicker.toggle()
                                self.showCameraPicker = false
                                self.pickAnImage.toggle()
                                self.showPopUp = false
                                
                            }
                            
                        }.transition(.scale)
                        .offset(y: -geometry.size.height/6)
                    }
                    HStack(alignment: .top){
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 25)
                            .padding(.top, 10)
                            .frame(width: geometry.size.width/6, height: 60)
                            .foregroundColor(self.viewRouter.currentView == "home" ? .black : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = "home"
                                withAnimation {
                                    self.showPopUp = false
                                }
                                
                            }
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 25)
                            .padding(.top, 10)
                            .frame(width: geometry.size.width/6, height: 60)
                            .foregroundColor(self.viewRouter.currentView == "explore" ? .black : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = "explore"
                                withAnimation {
                                    self.showPopUp = false
                                }
                            }
                        //PLUS BUTTON
                        ZStack {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 75, height: 75)
                            //                                .shadow(radius: 2)
                            
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.yellow)
                                .rotationEffect(Angle(degrees: self.showPopUp ? 45 : 0))
                        }
                        
                        .offset(y: -geometry.size.height/10/2)
                        .onTapGesture {
                            withAnimation {
                                self.showPopUp.toggle()
                            }
                        }
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 25)
                            .padding(.top, 10)
                            .frame(width: geometry.size.width/6, height: 60)
                            .foregroundColor(self.viewRouter.currentView == "profile" ? .black : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = "profile"
                                withAnimation {
                                    self.showPopUp = false
                                }
                                
                            }
//                        if pickAnImage == false{
                            Image(systemName: "gear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.bottom, 25)
                                .padding(.top, 10)
                                .frame(width: geometry.size.width/6, height: 60)
                                .foregroundColor(self.viewRouter.currentView == "settings" ? .black : .gray)
                                .onTapGesture {
                                    self.viewRouter.currentView = "settings"
                                    withAnimation {
                                        self.showPopUp = false
                                    }
                                    
                                }
//                        } else {
//                            Image(systemName: "person.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .padding(.bottom, 25)
//                                .padding(.top, 10)
//                                .frame(width: geometry.size.width/6, height: 60)
//                                .foregroundColor(self.viewRouter.currentView == "settings" ? .black : .gray)
//                                .onTapGesture {
//                                    //                                    self.viewRouter.currentView = "settings"
//
//                                    withAnimation {
//                                        self.showPopUp = false
//                                    }
//
//                                }
//                        }
                        
                    }
                    .sheet(isPresented: self.$pickAnImage, content: {
                        if self.showCameraPicker == true{
                            ImagePickerView(sourceType: .camera) { image in
                                self.image = image
                                if self.image != nil{
                                    self.viewRouter.currentView = "new-entry"
                                }
                            }
                            
                        }
                        else {
                            VStack{
                                ImagePickerView(sourceType: .photoLibrary) { image in
                                    self.image = image
                                    if self.image != nil{
                                        self.viewRouter.currentView = "new-entry"
                                    }
                                }.edgesIgnoringSafeArea(.vertical)
                                Spacer()
                            }.edgesIgnoringSafeArea(.vertical)
                            .background(Color.black)
                            
                        }
                        //                        VStack{
                        //                            Text("Hello")
                        //                            Text("World!!")
                        //                        }
                    })
                    .frame(width: geometry.size.width, height: geometry.size.height/10)
                }
                
            }
            .onAppear() {
                dataHandler.loadPostsFor(self.dataHandler.loggedInUser.id)
                print("USERNAME:")
                print(dataHandler.loggedInUser.profileImageURL)
            }
            
            
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)
            
        }
    }
}
