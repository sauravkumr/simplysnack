//
//  LoginPage.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 11/24/20.
//

import Foundation
import SwiftUI
import Firebase
import RealmSwift

struct LoginView: View{
    //OnBoarding
    @State private var showOnBoarding = false
    @AppStorage("ObboardBeenViewed") var hasOnboarded = false
    var onboardSet = OnboardData.buildSet()
    
    
    @ObservedObject var dataHandler: DataHandler
    @Binding var isLoggedInFull: Bool
    @Binding var doesRealmExist: Bool
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoading: Bool = false
//    @State var isLoaded: Bool = true
    //    @State var isLoggedIn: Bool = true
    @State var isPresented: Bool = false
    @State var isSignUpPresented: Bool = false
    @State var isFPPresented: Bool = false

    //    @State var showingAlert = false
    @State var loginError = false
    
    @State var forgotPasswordFailed = false

    @State var forgotPasswordWorked = false

    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error == nil{
                print("ASKJDHAJKSHDJKASHDKJAH Results: ", result!.user.uid)
                let user = UserObject()
                user.id = result!.user.uid ?? ""
                user.isLoggedIn.value = true
                user.writeToRealm()
                self.isLoggedInFull = true
//
//                let user = UserObject()
//                user.id = result?.user.uid ?? ""
//                user.isLoggedIn.value = true
//                user.writeToRealm()
//                self.isLoggedInFull = true
////                print("Result: ", result!)
////                print(dataHandler.loggedInUser.id)
//
////                isLoaded = false
//                loginError = false
//                self.doesRealmExist = true
//                withAnimation(.default){
//                    isLoggedInFull = true
//                }
                let ref = Database.database().reference().child("users")
                //            print(userID)
                ref.child(result!.user.uid).observeSingleEvent(of: .value) { snapshot in
                    guard let dict = snapshot.value as? [String: AnyObject] else {return}
                    dataHandler.loggedInUser = handleUserDictionary(dict)
                    dataHandler.loadPosts()
                }

            }else {
                print("error")
                loginError = true
            }
        }
    }
    
    var body: some View{
        NavigationView{
            ZStack{
                ZStack{
                    ZStack{
                        
                        //background gradient
                        Rectangle()
                            .fill(LinearGradient(
                                    gradient: Gradient(stops: [
                                                        .init(color: Color(#colorLiteral(red: 1, green: 0.8117647171020508, blue: 0.14901961386203766, alpha: 1)), location: 0),
                                                        .init(color: Color(#colorLiteral(red: 1, green: 0.5999999046325684, blue: 0, alpha: 1)), location: 1)]),
                                    startPoint: UnitPoint(x: 0.19066667537166743, y: 0.08312807224033718),
                                    endPoint: UnitPoint(x: 0.8599999308066857, y: 0.9722906080434965)))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        VStack{
                            Image("loginLogo").resizable().frame(width: (2 * UIScreen.main.bounds.width) / 5, height: (2 * UIScreen.main.bounds.width) / 5, alignment: .center).cornerRadius(25)
                            VStack{
                                Text("Simply").font(Font.custom("Futura", size: 50)).bold().foregroundColor(.white)
                                Text("Snack").font(Font.custom("Futura", size: 50)).bold().foregroundColor(.white)
                            }
                            ZStack{
                                RoundedRectangle(cornerRadius: 300)
                                    .fill(Color.white)
                                    .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                                //                        .shadow(color: lightGray, radius: 3)
                                TextField("Email...", text: $email).frame(width: UIScreen.main.bounds.width - 110)
                            }.padding(.top, 20)
                            
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 300)
                                    .fill(Color.white)
                                    .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                                //                        .shadow(color: lightGray, radius: 3)
                                SecureField("Password...", text: $password).frame(width: UIScreen.main.bounds.width - 110)
                            }.padding(.top, 10)
                            
                            Button(action: {login()}, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 300)
                                        .fill(Color.white)
                                        .frame(width: 150, height: 50)
                                    //                        .shadow(color: lightGray, radius: 3)
                                    Text("Login").font(.title).bold().foregroundColor(yellow)
                                }
                            })
                            .padding(.top, 20)
                            Button(action: {
                                signUp()
                            }, label: {
                                Text("Sign Up").foregroundColor(.white)
                            })
//                            Button(action: {
//                            }, label: {
//                                Text("Forgot Password").foregroundColor(.white)
//                            }).padding(.top)
                            NavigationLink(
                                destination: ForgotPassword(dataHandler: dataHandler),
                                label: {
                                    Text("Forgot Password").foregroundColor(.white)
                                }).padding(.top)

                        }
                        
                        
                    }.onAppear() {
//                        hasOnboarded = false
                        print("loginView Here")
                        if !hasOnboarded {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    showOnBoarding.toggle()
                                    hasOnboarded = true
                                }
                            }
                        }
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                    .offset(x: self.isLoggedInFull ? -UIScreen.main.bounds.width : 0, y: 0)
                    .zIndex(2)
                    .alert(isPresented: $loginError) {
                        Alert(title: Text("Login Failed"), message: Text("Incorrect email or password."), dismissButton: .default(Text("Dismiss")))
                    }
//                    .alert(isPresented: $loginError) {
//                        Alert(title: Text("Login Failed"), message: Text("Incorrect email or password."), dismissButton: .default(Text("Dismiss")))
//                    }
                    
//                    ContentView(dataHandler: dataHandler, isLoggedIn: self.$isLoggedInFull, doesRealmExist: self.$doesRealmExist).environmentObject(DataHandler()).zIndex(0)
//                        .offset(x: self.isLoggedInFull ? 0 : UIScreen.main.bounds.width, y: 0)
                }.navigationTitle("")
                .navigationBarHidden(true)
                .sheet(isPresented: self.$isPresented, content: {
                        SignUpView(dataHandler: dataHandler, isPresented: self.$isPresented, isLoggedIn : self.$isLoggedInFull, isSignUpPresented: self.$isSignUpPresented)
                })
                
                .disabled(showOnBoarding)
                .blur(radius: showOnBoarding ? 3.0 : 0)

                if showOnBoarding {
                    OnboardingScreens(isPresenting: $showOnBoarding, onboardSet: onboardSet)
                }
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
        
    }
    func signUp() {
        self.isPresented.toggle()
        self.isSignUpPresented.toggle()
    }
    func forgotPassword() {
//        self.isPresented.toggle()
//        self.isFPPresented.toggle()
    }
}

