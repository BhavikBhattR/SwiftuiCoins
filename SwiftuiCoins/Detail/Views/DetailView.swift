//
//  DetailView.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 29/01/23.
//

import SwiftUI

struct DetailLoadingView: View{
    @Binding var coin: CoinModel?
    
    var body: some View{
        ZStack{
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("initializing detail view for \(coin.name)")
    }
    
    
    var body: some View {
            ScrollView{
                
                VStack{
                    ChartView(coin: vm.coin)
                        .padding(.vertical)
                    VStack(spacing: 20){
                       overviewTitle
                       Divider()
                        
                       descriptionSection
            
                       overviewGrid
                       additionalTitle
                       Divider()
                       additionalGrid
                       websiteSections
                    }
                    .padding()
                }
               
            }
            .navigationTitle(vm.coin.name)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                  navigationBarTrailingItems
                }
            }
        }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView{
    
    private var navigationBarTrailingItems: some View{
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(Color.theme.secondaryTextColor)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View{
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View{
        ZStack{
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty{
                VStack(alignment: .leading){
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryTextColor)
                    Button {
                            showFullDescription.toggle()
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more ...")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var additionalTitle: some View{
        Text("Additional details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View{
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.overviewStatistic) { stat in
                   StatisticView(stat: stat)
               }
        })
    }
    
    private var additionalGrid: some View{
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.additionalStatistic) { stat in
                   StatisticView(stat: stat)
               }
        })
    }
    
    private var websiteSections: some View{
        VStack(alignment: .leading, spacing: 20){
            if let website = vm.websiteURL,
               let url = URL(string: website){
                Link("visit \(vm.coin.name) website page", destination: url)
            }
            
            if let reddit = vm.redditURL,
               let url = URL(string: reddit){
                Link("visit \(vm.coin.name) reddit page", destination: url)
            }
        }
            .tint(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.headline)
    }
    
}
