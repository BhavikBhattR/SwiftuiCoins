//
//  HepticManager.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 29/01/23.
//

import Foundation
import SwiftUI

class HepticManager{
    
    private static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
    
}
