//
//  SignUpPage.swift
//  Memestragram2
//
//  Created by Jared on 6/12/20.
//  Copyright © 2020 Archetapp. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct SignUpView : View {
    @State var email : String = ""
    @State var username : String = ""
    @State var password1 : String = ""
    @State var password2 : String = ""
    
    @ObservedObject var dataHandler: DataHandler
    @Binding var isPresented : Bool
    @Binding var isLoggedIn : Bool
    @Binding var isSignUpPresented: Bool
    
//    init(isPresented : Binding<Bool>, isLoggedIn : Binding<Bool>, dataHandler) {
//        _isPresented = isPresented
//        _isLoggedIn = isLoggedIn
//        _dataHandler = dataHandler
//        UITableView.appearance().backgroundColor = .white
//        UITableView.appearance().separatorColor = .clear
//    }
    
    var body : some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text:  self.$username).frame(height: 60, alignment: .center)
                    TextField("Email", text: self.$email).frame(height: 60, alignment: .center)
                    SecureField("Password", text: self.$password1).frame(height: 60, alignment: .center)
                    SecureField("Password (Again)", text: self.$password2).frame(height: 60, alignment: .center)
                }
                Section {
                    Button(action: self.submit, label: {Text("Submit").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)}).background(yellow).cornerRadius(10).padding()
                }
            }.navigationBarTitle("Sign Up")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    func submit() {
        self.isPresented.toggle()
        if password1 == password2 {
            Auth.auth().createUser(withEmail: self.email, password: self.password1) { (result, error) in
                if error == nil {
                    
                    let user = UserObject()
                    user.id = result?.user.uid ?? ""
                    user.username = self.username
                    user.isLoggedIn.value = true
                    user.writeToRealm()
                    
                    let ref = Database.database().reference().child("users")
                    ref.child(user.id).updateChildValues(["uid" : user.id,
                                                          "username" : self.username])
                    
                    self.isLoggedIn = true
                    self.isPresented = false
                    self.isSignUpPresented = false
                    self.dataHandler.loadPosts()

                } else {
                    print(error)
                }
            }
        }
        
    }
}
