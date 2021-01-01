//
//  LoadingScreen.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 12/20/20.
//

import Foundation
import SwiftUI

var darkGray = Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255)

struct LoadingScreenView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 1, green: 0.8117647171020508, blue: 0.14901961386203766, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 1, green: 0.5999999046325684, blue: 0, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0.19066667537166743, y: 0.08312807224033718),
                        endPoint: UnitPoint(x: 0.8599999308066857, y: 0.9722906080434965)))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            VStack{
//                Text("Simply Snack").font(Font.custom("Roboto-Medium", size: 40)).foregroundColor(darkGray)
                Image("logoSmileBig")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 2 * UIScreen.main.bounds.width/3, alignment: .center)
            }

            
        }
    }
}
