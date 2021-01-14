//
//  File.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/27/20.
//

import Foundation
import SwiftUI

struct ImagePickerExampleView: View {

    @State var showImagePicker: Bool = false
    @State var image: UIImage?

    var body: some View {
        VStack {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Button("Pick image") {
                self.showImagePicker.toggle()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                self.image = image
            }
        }
    }
}
