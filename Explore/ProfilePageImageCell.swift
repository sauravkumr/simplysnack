//
//  ProfilePageImageCell.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 12/21/20.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ProfilePageImageCellView: View {
    @StateObject var dataHandler: DataHandler
    var currentPost: Post
    @State var fullPost = false

    var body: some View {
        VStack(spacing: 0){
            WebImage(url: URL(string: self.currentPost.imageURL), options: .highPriority, context: nil)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (UIScreen.main.bounds.width/3), height: (UIScreen.main.bounds.width/3))
                .contentShape(Rectangle())
                .clipped()
                .id(currentPost.id)
        }
        .onTapGesture {
            self.fullPost.toggle()
            print(self.currentPost.id)
        }
        .sheet(isPresented: self.$fullPost, content: {
            FullPostCell(dataHandler: dataHandler, image: self.currentPost.imageURL, date: self.currentPost.date?.formatDate() ?? "", description: self.currentPost.comment, title: self.currentPost.title, currentPost: currentPost)
        })
    }
}
