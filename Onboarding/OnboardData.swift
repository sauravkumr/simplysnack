//
//  OnboardData.swift
//  Onboarding
//
//  Created by Stewart Lynch on 2020-06-27.
//

import UIKit

enum OnboardData {
    static func buildSet(width:CGFloat = 350, height: CGFloat = 350) -> OnboardSet {
        let onboardSet = OnboardSet()
        onboardSet.dimensions(width: width, height: height)
        onboardSet.newCard(title: "Welcome",
                           image: "welcome",
                           text: "Welcome to Simply Snack - The fastest, easiest, and most convenient food diary on the App Store!")
        onboardSet.newCard(title: "Today View",
                           image: "diary",
                           text: "The Today View is your daily dairy. View at a glance what you ate today and check ur progress for your meal goal.")
        onboardSet.newCard(title: "Profile",
                           image: "profile",
                           text: "Never wonder what you ate again and see an up-to-date diary of your meals for every meal you have logged.")
        onboardSet.newCard(title: "Explore",
                           image: "explore",
                           text: "View new recipes from all around the world every day - or stick to the classics.")
        onboardSet.newCard(title: "Jump In!",
                           image: "login",
                           text: "Get started by logging in or signing up. All you need to get started is an email and password.")
        return onboardSet
    }
}
