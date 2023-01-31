//
//  Date.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 30/01/23.
//

import Foundation

extension Date{
    
    init(coinGeckoString: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func shortDateAsString() -> String{
        shortFormatter.string(from: self)
    }
    
}
