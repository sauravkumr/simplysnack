//
//  PublicExtensions.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 11/28/20.
//

import Foundation
import RealmSwift

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601: String { return Formatter.iso8601.string(from: self) }
}

extension String {
    var iso8601: Date? { return Formatter.iso8601.date(from: self) }
}

extension Object {
    func writeToRealm(){
        try! uiRealm.write({
            uiRealm.add(self, update: .all)
        })
    }
    
    func updateToRealm(){
        try! uiRealm.write({
            uiRealm.add(self, update: .modified)
        })
    }
}

func handlePostDictionary(_ dict: [String: AnyObject]) -> Post{
    let post = Post()
    
    post.id = dict["id"] as? String ?? ""
    post.comment = dict["comment"] as? String ?? ""
    post.date = (dict["date"] as? String ?? "").iso8601
    post.aspectRatio = dict["aspectRatio"] as? Double ?? 1.0
    post.title = dict["title"] as? String ?? ""
    post.imageURL = dict["imageURL"] as? String ?? ""
//    post.uid = dict["uid"] as? String ?? ""
    post.writeToRealm()
    return post
}

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}

func handleUserDictionary(_ dict: [String: AnyObject]) -> UserObject{
    let user = UserObject()
    
    user.id = dict["uid"] as? String ?? ""
    user.username = dict["username"] as? String ?? ""
    user.profileImageURL = dict["profileImage"] as? String ?? ""
    print("HERE: " + user.profileImageURL + user.username)
//    user.image = dict["username"] as? String ?? ""

    user.writeToRealm()
    return user
}
