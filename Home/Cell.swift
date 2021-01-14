//
//  Cell.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/23/20.
//

import Foundation
import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct EntryCell: View{
    var image: String
    var title: String
//    var image: String

    var body: some View{
        ZStack{
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width - 30, height: 150)
                .shadow(radius: 7)
            HStack{
                WebImage(url: URL(string: image), options: .highPriority, context: nil)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .cornerRadius(20)
                VStack(alignment: .leading){
                    Text(title).font(.headline).fontWeight(.bold).foregroundColor(Color.black)
                    Text("October 19, 4:37 PM").font(.caption).foregroundColor(Color.gray)
                }.padding(.leading, 20)
                .frame(width: UIScreen.main.bounds.width - 200)
                Spacer()
            }.padding(.leading, 25)
            Spacer()
        }
    }
}

struct webView: UIViewRepresentable {
    
    var url: String
    func makeUIView(context: UIViewRepresentableContext<webView>) -> WKWebView  {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        return view
    }
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView>) {
        
    }
}
