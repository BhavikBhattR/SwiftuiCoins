//
//  MarketDataService.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 28/01/23.
//

import Foundation
import Combine

class MarketDataService{
    
    @Published var marketData : MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init(){
        getData()
    }
    
     func getData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("\(error) done bro")
                }
            } receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            }
        

    }
    
}
