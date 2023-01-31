//
//  CoinImageService.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 26/01/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    
    @Published var image: UIImage? = nil
    var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName: String = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
        }else{
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap{ data -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("\(error) done bro")
                }
            } receiveValue: { [weak self] returnedImage in
                guard let
                        self = self,
                        let returnedImage = returnedImage
                else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: returnedImage, imageName: self.imageName, folderName: self.folderName)
            }
    }
    
}
