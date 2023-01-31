//
//  Double.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 12/01/23.
//

import Foundation


extension Double{
    
    ///converts a double into a currency with 2 decimal places
    ///```
    ///Considering local currency is dollar
    ///->Converts 1234.56 to $1234.56
    ///->Converts 12.3456789 to $12.34
    ///->Coverts 12.3 to $12.30
    ///```
    private var currencyFormatter2: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = formatter.locale.currency?.identifier ?? "usd"
        formatter.currencySymbol = formatter.locale.currencySymbol ?? "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    
    ///converts a double into a currency as a string with 2 decimal places
    ///```
    ///Considering local currency is dollar
    ///->Converts 1234.56 to "$1234.56"
    ///->Converts 12.3456789 to "$12.34"
    ///->Coverts 12.3 to "$12.30"
    ///```
    func asCurrencyWith2Decimals() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "\(Locale.current.currency?.identifier ?? "usd")0.00"
    }
    
    

    
    ///converts a double into a currency with 2-6 decimal places
    ///```
    ///Considering local currency is dollar
    ///->Converts 1234.56 to $1234.56
    ///->Converts 12.3456789 to $12.345678
    ///->Coverts 12.3 to $12.30
    ///```
    private var currencyFormatter6: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = formatter.locale.currency?.identifier ?? "usd"
        formatter.currencySymbol = formatter.locale.currencySymbol ?? "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    
    ///converts a double into a currency as a string with 2-6 decimal places
    ///```
    ///Considering local currency is dollar
    ///->Converts 1234.56 to "$1234.56"
    ///->Converts 12.3456789 to "$12.345678"
    ///->Coverts 12.3 to "$12.30"
    ///```

    func asCurrencyWith6Decimals() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "\(Locale.current.currency?.identifier ?? "usd")0.00"
    }
    
    
    ///converts  a double into a string representation
    ///```
    ///converts 2.435 to "2.34"
    ///converts 2.3 to "2.30"
    ///converts 2 to "2.00"
    ///```
    func asNumberString() -> String{
        return String(format: "%.2f", self)
    }
    
    
    ///converts  a double into a string representation with % symbol
    ///```
    ///converts 2.435 to "2.34%"
    ///converts 2.3 to "2.30%"
    ///converts 2 to "2.00%"
    ///```
    func asPercentageString() -> String{
        return "\(asNumberString())%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
    
}
