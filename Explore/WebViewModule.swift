//
//  WebViewModule.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 12/22/20.
//

import Foundation
import SwiftUI
import WebKit

struct webView: UIViewRepresentable {
    
    var url: String
    func makeUIView(context: UIViewRepresentableContext<webView>) -> WKWebView  {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: "https://www.google.com/")!))
        return view
    }
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView>) {
        
    }
}
