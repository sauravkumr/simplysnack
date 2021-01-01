//
//  OnboardSet.swift
//  Onboarding
//
//  Created by Stewart Lynch on 2020-06-27.
//

import UIKit

class OnboardSet {
    private(set) var cards: [OnboardCard] = []
    private(set) var width: CGFloat = 350
    private(set) var height: CGFloat = 350
    
    func dimensions(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    func newCard(title: String, image: String, text: String) {
        cards.append(OnboardCard(title: title, image: image, text: text))
    }
}
