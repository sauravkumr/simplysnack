////
////  ImagePicker.swift
////  Memestragram2
////
////  Created by Jared on 6/11/20.
////  Copyright © 2020 Archetapp. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//
//
//class ImagePickerCordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
//
//    @Binding var isShown    : Bool
//    @Binding var image      : Image?
//    @Binding var uiImage    : UIImage?
//
//    init(isShown : Binding<Bool>, image: Binding<Image?>, uiImage : Binding<UIImage?>) {
//        _isShown = isShown
//        _image   = image
//        _uiImage = uiImage
//    }
//    
//    //Selected Image
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        image = Image(uiImage: uiImage)
//        self.uiImage = uiImage
//        isShown = false
//    }
//
//    //Image selection got cancel
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        isShown = false
//    }
//}
//
//struct ImagePicker : UIViewControllerRepresentable {
//
//    @Binding var isShown    : Bool
//    @Binding var image      : Image?
//    @Binding var uiImage    : UIImage?
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//
//    func makeCoordinator() -> ImagePickerCordinator {
//        return ImagePickerCordinator(isShown: $isShown, image: $image, uiImage: $uiImage)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//}
