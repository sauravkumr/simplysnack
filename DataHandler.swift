//
//  DataHandler.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 11/28/20.
//

import Foundation
import SwiftUI
import Firebase

let date = Date()
let dateFormatter = DateFormatter()
let currentDateString: String = dateFormatter.string(from: date)


class DataHandler: ObservableObject{
    @Published var HomePagePosts = [Post]()
    @Published var TodayPagePosts = [Post]()
    @Published var loggedInUser = UserObject()
    //    @Published var temporaryPosts = [PostIdentifiable]()
    @Published var profilePagePosts = [PostIdentifiable]()
    @Published var numberOfTodayPosts = 0
    
    
    //    init() {
    //        self.loadHomePagePosts()
    //    }
    
    func loadHomePagePosts(){
    
    }
    func loadPosts(){
        let ref = Database.database().reference()
        //            .queryOrdered(byChild: "uid").queryEqual(toValue: loggedInUser.id)
        print(loggedInUser.id)
        ref.child("Posts").queryOrdered(byChild: "uid").queryEqual(toValue: loggedInUser.id).observe(.value) { post in
            self.TodayPagePosts.removeAll()
            self.HomePagePosts.removeAll()
            
            print("BELOW IS UID")
            //            self.numberOfTodayPosts = 0
            //            post.
            
            for entry in post.children.allObjects as! [DataSnapshot] {
                guard let dict = entry.value as? [String: AnyObject] else {return}
                //                    if "\(entry.childSnapshot(forPath: "uid").value ?? "")" == self.loggedInUser.id {
                let dateOfPost = "\(entry.childSnapshot(forPath: "todayDate").value ?? "")"
                //                        print(Calendar.current.dateComponents([.day], from: dateOfPost))
                if dateOfPost == formatter1.string(from: today) {
                    print("date working")
                    self.TodayPagePosts.append(handlePostDictionary(dict))
                    
                }
                self.HomePagePosts.append(handlePostDictionary(dict))
            }
//            postsLoaded = true
            self.HomePagePosts.sort(by: {$0.date!.compare($1.date!) == .orderedDescending})
            self.TodayPagePosts.sort(by: {$0.date!.compare($1.date!) == .orderedDescending})

            self.numberOfTodayPosts = self.TodayPagePosts.count

        }
    }
    
    
    func loadPostsFor(_ user: String) {
        let ref = Database.database().reference()
        print(user)
        print(loggedInUser.id)
        
        ref.child("Posts").queryOrdered(byChild: "uid").queryEqual(toValue: user).observe(.value) { post in
            //                self.HomePagePosts.removeAll()
            for entry in post.children.allObjects as! [DataSnapshot] {
                guard let dict = entry.value as? [String: AnyObject] else {return}
                self.profilePagePosts.append(PostIdentifiable(post: handlePostDictionary(dict)))
            }
            self.profilePagePosts.sort(by: {$0.post.date!.compare($1.post.date!) == .orderedDescending})
            
        }
        
    }
    
    func checkIfLoggedIn(completion: @escaping(_ isLoggedIn: Bool) -> ()){
        
        guard let userID = Auth.auth().currentUser?.uid else{
            completion(false)
            print("userID error")
            return
        }
        
        if uiRealm.object(ofType: UserObject.self, forPrimaryKey: userID) != nil{
            let ref = Database.database().reference().child("users")
            //            print(userID)
            ref.child(userID).observeSingleEvent(of: .value) { snapshot in
                guard let dict = snapshot.value as? [String: AnyObject] else {return}
                self.loggedInUser = handleUserDictionary(dict)

                completion(true)
            }
        } else {
            let ref = Database.database().reference().child("users")
            //            print(userID)
            ref.child(userID).observeSingleEvent(of: .value) { snapshot in
                guard let dict = snapshot.value as? [String: AnyObject] else {return}
                self.loggedInUser = handleUserDictionary(dict)

                completion(true)
            }
            
            completion(true)
//            print("not logged in")
        }
        
    }
}
