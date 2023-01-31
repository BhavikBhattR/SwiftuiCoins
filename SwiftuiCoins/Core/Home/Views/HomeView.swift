//
//  HomeView.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 12/01/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var isShowingPortfolio : Bool = false
    @State private var isshowingPortfolioView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var isShowSettingsView:Bool = false
    
    
    var body: some View {
            GeometryReader{ geo in
                ZStack{
                    
                    // background layer
                    Color.theme.background.ignoresSafeArea()
                        .sheet(isPresented: $isshowingPortfolioView) {
                            PortfolioView()
                                .environmentObject(vm)
                        }
                    
                    //content layer
                    VStack{
                        homeHeader
                        
                        HomeStatView(showPortfolio: $isShowingPortfolio)
                        
                        SearchBarView(searchText: $vm.searchText)
                        
                        // returns HStack of titles for every column
                        returnColumnTitles(geo: geo)
                        
                        if !isShowingPortfolio{
                            allCoinsList
                                .transition(.move(edge: .leading))
                        }
                        
                        if isShowingPortfolio{
                            ZStack{
                                if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty{
                                  portfolioEmptyText
                                }
                            }
                            portfolioCoinsList
                                .transition(.move(edge: .trailing))
                        }
                        
                        
                        Spacer(minLength: 0)
                    }
                    .sheet(isPresented: $isShowSettingsView) {
                        SettingsView()
                    }
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .toolbar(.hidden, for: .navigationBar)
        }
        .environmentObject(DeveloperPreview.instance.homeVM)
    }
}


extension HomeView{
    
    private func returnColumnTitles(geo: GeometryProxy) -> some View{
        HStack{
            HStack(spacing: 4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation{
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            HStack(spacing: 4){
                if isShowingPortfolio{
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
            }.onTapGesture {
                withAnimation{
                    vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                }
            }
            
            HStack(spacing: 4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: geo.size.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation{
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            
            Button {
                withAnimation(.linear(duration: 2.0)){
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360: 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
    
    
    private var homeHeader : some View{
        HStack{
            CircleButtonView(iconName: isShowingPortfolio ? "plus" : "info")
                .animation(.none, value: isShowingPortfolio)
                .onTapGesture {
                    if isShowingPortfolio{
                        isshowingPortfolioView.toggle()
                    }else{
                        isShowSettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $isShowingPortfolio)
                )
            Spacer()
            Text(isShowingPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(isShowingPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        isShowingPortfolio.toggle()
                    }
                }
        }.padding(.horizontal)
    }
    
    
    private var allCoinsList: some View{
            List{
                ForEach(vm.allCoins){coin in
                    CoinRowView(coin: coin, showCurrentHoldingsColumn: isShowingPortfolio)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .onTapGesture {
                            segue(coin: coin)
                        }
                }
            }.navigationDestination(isPresented: $showDetailView, destination: {
                DetailLoadingView(coin: $selectedCoin)
            })
            .listStyle(.plain)
    }
    
    private var portfolioEmptyText: some View{
        Text("You have no coins in your portfolio yet. You can add by clicking the + button shown on top left screen 🤟")
            .font(.callout)
            .foregroundColor(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var portfolioCoinsList: some View{
        List{
            ForEach(vm.portfolioCoins){coin in
                CoinRowView(coin: coin, showCurrentHoldingsColumn: isShowingPortfolio)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }.navigationDestination(isPresented: $showDetailView, destination: {
            DetailLoadingView(coin: $selectedCoin)
        })
        .listStyle(.plain)
    }
    
    private func segue(coin: CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
    }
}
