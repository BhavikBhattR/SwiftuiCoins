//
//  DetailViewModel.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 30/01/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject{
    
    private let coinDetailService: CoinDetailDataService
    private var anyCancellables = Set<AnyCancellable>()
    @Published var overviewStatistic: [StatisticModel] = []
    @Published var additionalStatistic: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    @Published var coin: CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(getOverviewAndAdditionalDetailOfCoin)
            .sink { [weak self] returnedArrays in
                self?.additionalStatistic = returnedArrays.additional
                self?.overviewStatistic = returnedArrays.overview
            }
            .store(in: &anyCancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &anyCancellables)
    }
    
    private func getOverviewOfCoin(coinModel: CoinModel) -> [StatisticModel]{
        
        // overview stats
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overview:[StatisticModel] = [priceStat, marketCapStat, rankStat, volumeStat]
        
        return overview
    }
    
    private func getAdditionDetailOfCoin(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel]{
        
        // additional stat
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "N/A"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "N/A"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "N/A"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? ""
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "N/A"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let addiional: [StatisticModel] = [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
        
        return addiional
    }
    
    private func getOverviewAndAdditionalDetailOfCoin(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]){
       return (getOverviewOfCoin(coinModel: coinModel), getAdditionDetailOfCoin(coinDetailModel: coinDetailModel, coinModel: coinModel))
    }
}
