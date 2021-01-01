
import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var dataHandler: DataHandler
    @State var isLoggedIn = false
    @State var isLoaded = false
    @State var doesRealmExist = true
    @State var wifiFailure = false
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Group{
            if isLoaded == false{
                LoadingScreenView().onReceive(timer) { input in
                    wifiFailure = true
                }.alert(isPresented: $wifiFailure) {
                    Alert(title: Text("Error"), message: Text("Please connect to WiFi and try again."), dismissButton: .default(Text("Dismiss")))
                }
                
                
            } else {
                if isLoggedIn == true {
                    ContentView(dataHandler: dataHandler, isLoggedIn: self.$isLoggedIn, doesRealmExist: self.$doesRealmExist)
                } else {
                    LoginView(dataHandler: dataHandler, isLoggedInFull: self.$isLoggedIn, doesRealmExist: self.$doesRealmExist)
                }
            }
        }.onAppear() {
            self.dataHandler.checkIfLoggedIn { isLoggedIn in
                //                self.dataHandler.loadHomePagePosts()
                if isLoggedIn == true{
                    self.isLoggedIn = true
                    self.isLoaded = true
                    doesRealmExist = true
                    
//                    print(dataHandler.loggedInUser.id)
                    self.dataHandler.loadPosts()
                    print("loggedin")
                    print(dataHandler.loggedInUser.id)
                } else {
                    self.isLoggedIn = false
                    print("loggedout")
                    self.isLoaded = true
                    doesRealmExist = false
                }
            }
        }
    }
}
