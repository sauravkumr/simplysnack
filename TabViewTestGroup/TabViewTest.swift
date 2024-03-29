//File: ContentView.swift
//Project: CustomTabBarInSwiftUI

//Created at 02.12.19 by BLCKBIRDS
//Visit www.BLCKBIRDS.com for more.

import SwiftUI

var showTabBar = true

struct ContentView: View {
    
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    
    @ObservedObject var viewRouter = ViewRouter()
    
    @State var showPopUp = false
    
    var body: some View {
        //try to make a navigation view?
        GeometryReader { geometry in
            VStack(spacing: 0){
                Spacer()
                if self.viewRouter.currentView == "home" {
                    HomeView2()
                } else if self.viewRouter.currentView == "profile" {
                    ProfileView()
                }
                else if self.viewRouter.currentView == "new-entry" {
//                    NavigationLink(destination: NewEntryView(image: self.image))
                    NewEntryView(image: self.image)
                }else if self.viewRouter.currentView == "settings" {
                    HomeView2()
                }
                Spacer()
                //POPUP STUFF
                ZStack {
                    
//                    Circle()
//                        .foregroundColor(lightGray)
//                        .frame(width: 77, height: 77)
//                        .offset(y: -geometry.size.height/10/2)
//                        .zIndex(-1)
                    if self.showPopUp {
                        HStack(spacing: 50) {

                            ZStack {
                                Circle()
                                    .foregroundColor(yellow)
                                    .frame(width: 70, height: 70)
                                Image(systemName: "camera")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(20)
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.white)
                            }.onTapGesture {
                                self.viewRouter.currentView = "new-entry"
                                self.showPopUp = false
                        }

                            ZStack {
                                Circle()
                                    .foregroundColor(yellow)
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
                                .foregroundColor(self.viewRouter.currentView == "settings" ? .black : .gray)
                                .onTapGesture {
                                    self.viewRouter.currentView = "settings"
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
                                .foregroundColor(yellow)
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
                    }
//                    .shadow(color: lightGray, radius: 2)

                        .frame(width: geometry.size.width, height: geometry.size.height/10)
//                                        .background(Color.white.shadow(radius: 2))
//                    .border(Color.red, width: 4)
//                    .background(Color.white)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)

            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.image = image
                    if self.image != nil{
                        self.viewRouter.currentView = "new-entry"
                    }
                }
            }
        }
    }
}

//struct PlusMenu: View {
//    @ObservedObject var viewRouter = ViewRouter()
//    var body: some View {
//            HStack(spacing: 50) {
//
//                ZStack {
//                    Circle()
//                        .foregroundColor(yellow)
//                        .frame(width: 70, height: 70)
//                    Image(systemName: "camera")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(20)
//                        .frame(width: 70, height: 70)
//                        .foregroundColor(.white)
//                }.onTapGesture {
//                    self.viewRouter.currentView = "new-entry"
//            }
//
//                ZStack {
//                    Circle()
//                        .foregroundColor(yellow)
//                        .frame(width: 70, height: 70)
//                    Image(systemName: "photo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(20)
//                        .frame(width: 70, height: 70)
//                        .foregroundColor(.white)
//                }.onTapGesture {
//                    self.viewRouter.currentView = "new-entry"
//            }
//            }.transition(.scale)
//
//    }
//}
