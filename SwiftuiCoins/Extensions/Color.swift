//
//  Color.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 12/01/23.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launchColorTheme = LaunchColorTheme()
    
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryTextColor = Color("SecondaryTextColor")
    
}


struct LaunchColorTheme{
    let launchBackgroundColor = Color("LaunchBackgroundColor")
    let launchAccentColor = Color("LaunchAccentColor")
}
