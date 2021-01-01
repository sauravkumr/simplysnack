//
//  ForgotPassword.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 12/30/20.
//

import Foundation
import SwiftUI
import Firebase

struct ForgotPassword : View {
    @State var email : String = ""
    
    @ObservedObject var dataHandler: DataHandler
//    @Binding var isPresented : Bool
//    @Binding var isFPPresented: Bool

    
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
                    TextField("Email", text: self.$email).frame(height: 60, alignment: .center)
                }
                Section {
                    Button(action: self.submit, label: {Text("Send Reset Link").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)}).background(yellow).cornerRadius(10).padding()
                }
            }.navigationBarTitle("Forgot Password")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    func submit() {
//        self.isPresented = false
//        self.isFPPresented = false
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("error")
            } else {
                
            }
        }

    }
}
