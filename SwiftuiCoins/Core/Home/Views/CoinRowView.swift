//
//  CoinRowView.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 12/01/23.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    var showCurrentHoldingsColumn : Bool
    
    var body: some View {
        GeometryReader{ geo in
            HStack(spacing: 0){
                leftColumn
                
                Spacer()
                
                if showCurrentHoldingsColumn{
                    centerColumn
                }
                
                rightColumn
                    .frame(width: geo.size.width / 3.5, alignment: .trailing)
                
            }
            .font(.subheadline)
            .contentShape(Rectangle())
        }
    }
}

extension CoinRowView{
    
    private var leftColumn: some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View{
        VStack(alignment: .trailing){
            Text(coin.currentHoldinValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    

    
    private var rightColumn: some View{
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "0.00%")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0
                    ? Color.theme.green
                    : Color.theme.red
                )
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CoinRowView(coin: Self.dev.coin, showCurrentHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
        }
    }
}
