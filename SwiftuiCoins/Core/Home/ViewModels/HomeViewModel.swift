//
//  HomeViewModel.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 13/01/23.
//

import Foundation
import Combine


class HomeViewModel :ObservableObject{
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    var cancellables = Set<AnyCancellable>()
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: sortOptions = .holdings
    @Published var statistics: [StatisticModel] = [
       ]
    
    enum sortOptions{
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init(){
       addSubscriber()
    }
    
    func addSubscriber(){
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedFilteredCoins in
                self?.allCoins = returnedFilteredCoins
            }
            .store(in: &cancellables)
        
        // updates the portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllcoinsToPortfoliocoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        // updates marketData or statistics
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false 
            }
            .store(in: &cancellables)
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HepticManager.notification(type: .success)
    }
    
    private func mapAllcoinsToPortfoliocoins(coinModels: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel]{
        coinModels
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else{
                    return nil
                }
                return coin.updateHolding(amount: entity.amount)
            }
    }
    
    private func filterAndSortCoins(text: String, startingCoins: [CoinModel], sort: sortOptions) -> [CoinModel]{
        var updatedCoins = filteredCoins(text: text, startingCoins: startingCoins)
        sortedCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortedCoins(sort: sortOptions, coins: inout [CoinModel]){
        switch sort{
        case .rank, .holdings:
             coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
             coins.sort(by: {$0.rank > $1.rank})
        case .price:
             coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
             coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel]{
        // this will sort the coins by holdings or reversedHoldings only if needed
        switch sortOption{
        case .holdings:
            return coins.sorted(by: {$0.currentHoldinValue > $1.currentHoldinValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldinValue < $1.currentHoldinValue})
        default:
            return coins
        }
    }
    
    private func filteredCoins(text: String, startingCoins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return startingCoins
        }
        let lowerCasedText = text.lowercased()
        return startingCoins.filter { (coin) in
            return coin.name.lowercased().contains(lowerCasedText) ||
            coin.symbol.lowercased().contains(lowerCasedText) ||
            coin.id.lowercased().contains(lowerCasedText)
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                         
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue =
            portfolioCoins
                .map({$0.currentHoldinValue})
                .reduce(0, +)
        
        let previousValue =
                portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldinValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portFolioValue = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
        marketCap,
        volume,
        btcDominance,
        portFolioValue
        ])
        
        return stats
    }
    
}
