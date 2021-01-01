//
//  RealmObjects.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 11/28/20.
//

import Foundation
import RealmSwift

class Post: Object{
    @objc dynamic var id: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var comment: String = ""
    @objc dynamic var date: Date? = nil
    @objc dynamic var aspectRatio: Double = 0
    @objc dynamic var title: String = ""
    @objc dynamic var user: UserObject? = nil

    var isFavorited = RealmOptional<Bool>()

    override class func primaryKey() -> String? {
        return "id"
    }
}

class UserObject: Object{
    @objc dynamic var id: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var profileImageURL: String = ""
    var isLoggedIn = RealmOptional<Bool>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
