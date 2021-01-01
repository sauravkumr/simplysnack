//
//  OBCardView.swift
//  Onboarding
//
//  Created by Stewart Lynch on 2020-06-27.
//

import SwiftUI

struct OBCardView: View {
    @Binding var isShowing: Bool
    let card: OnboardCard
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(card.title)
                    .font(.title).bold()
                Spacer()
                Button(action: {
                    withAnimation {
                        isShowing = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                }
            }
            Image(card.image)
                .resizable()
                .scaledToFit()
            Text(card.text)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top,10)
        .frame(width: width, height: height)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/))
    }
}
