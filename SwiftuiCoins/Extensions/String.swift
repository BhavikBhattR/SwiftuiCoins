//
//  String.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 30/01/23.
//

import Foundation

extension String{
    
    var removingHTMLOcurrences: String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
